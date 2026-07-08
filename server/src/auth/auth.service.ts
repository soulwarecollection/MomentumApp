import {
  Injectable,
  ConflictException,
  UnauthorizedException,
} from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import * as bcrypt from "bcrypt";
import type { StringValue } from "ms";
import { v4 as uuidv4 } from "uuid";
import { PrismaService } from "../prisma/prisma.service";
import { RegisterDto } from "./dto/register.dto";
import { LoginDto } from "./dto/login.dto";

export interface TokenPair {
  accessToken: string;
  refreshToken: string;
}

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) {}

  async register(dto: RegisterDto): Promise<TokenPair> {
    const existing = await this.prisma.user.findUnique({
      where: { email: dto.email },
    });
    if (existing) throw new ConflictException("Email already registered");

    const passwordHash = await bcrypt.hash(dto.password, 12);
    const user = await this.prisma.user.create({
      data: { email: dto.email, passwordHash },
    });

    return this.issueTokens(user.id, user.email);
  }

  async login(dto: LoginDto): Promise<TokenPair> {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email },
    });
    if (!user) throw new UnauthorizedException("Invalid credentials");

    const valid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!valid) throw new UnauthorizedException("Invalid credentials");

    return this.issueTokens(user.id, user.email);
  }

  async refresh(rawRefreshToken: string): Promise<TokenPair> {
    let payload: { sub: string; jti: string; type: string };
    try {
      payload = this.jwt.verify(rawRefreshToken, {
        secret: this.config.getOrThrow("JWT_REFRESH_SECRET"),
      });
    } catch {
      throw new UnauthorizedException("Invalid refresh token");
    }

    if (payload.type !== "refresh") {
      throw new UnauthorizedException("Invalid token type");
    }

    const stored = await this.prisma.refreshToken.findUnique({
      where: { jti: payload.jti },
      include: { user: true },
    });

    if (!stored || stored.expiresAt < new Date()) {
      throw new UnauthorizedException("Refresh token expired or revoked");
    }

    // Rotate: delete old token, issue new pair
    await this.prisma.refreshToken.delete({ where: { jti: payload.jti } });
    return this.issueTokens(stored.user.id, stored.user.email);
  }

  private async issueTokens(userId: string, email: string): Promise<TokenPair> {
    // jti keeps consecutively-issued access tokens unique even when signed
    // within the same second (iat has only second-granularity), which
    // otherwise made two same-second refreshes return byte-identical tokens.
    const accessToken = this.jwt.sign(
      { sub: userId, email, jti: uuidv4() },
      {
        secret: this.config.getOrThrow("JWT_ACCESS_SECRET"),
        expiresIn:
          this.config.get<StringValue>("JWT_ACCESS_EXPIRES_IN") ?? "15m",
      },
    );

    const jti = uuidv4();
    const refreshExpiresIn =
      this.config.get<StringValue>("JWT_REFRESH_EXPIRES_IN") ?? "7d";
    const refreshToken = this.jwt.sign(
      { sub: userId, jti, type: "refresh" },
      {
        secret: this.config.getOrThrow("JWT_REFRESH_SECRET"),
        expiresIn: refreshExpiresIn,
      },
    );

    const expiresAt = new Date();
    expiresAt.setDate(expiresAt.getDate() + 7); // mirrors JWT_REFRESH_EXPIRES_IN default

    await this.prisma.refreshToken.create({
      data: { jti, userId, expiresAt },
    });

    return { accessToken, refreshToken };
  }
}
