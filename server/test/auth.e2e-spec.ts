import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication, ValidationPipe } from "@nestjs/common";
import * as request from "supertest";
import { AppModule } from "src/app.module";
import { PrismaService } from "src/prisma/prisma.service";

const TEST_EMAIL = `auth-e2e-${Date.now()}@test.local`;
const TEST_PASSWORD = "Password123!";

describe("Auth (e2e)", () => {
  let app: INestApplication;
  let prisma: PrismaService;
  let accessToken: string;
  let refreshToken: string;

  beforeAll(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = module.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
      }),
    );
    await app.init();

    prisma = module.get(PrismaService);
  });

  afterAll(async () => {
    await prisma.user.deleteMany({
      where: { email: { startsWith: "auth-e2e-" } },
    });
    await app.close();
  });

  describe("POST /auth/register", () => {
    it("creates a user and returns token pair", async () => {
      const res = await request(app.getHttpServer())
        .post("/auth/register")
        .send({ email: TEST_EMAIL, password: TEST_PASSWORD })
        .expect(201);

      expect(res.body).toMatchObject({
        accessToken: expect.any(String),
        refreshToken: expect.any(String),
      });
      accessToken = res.body.accessToken;
      refreshToken = res.body.refreshToken;
    });

    it("rejects duplicate email with 409", async () => {
      await request(app.getHttpServer())
        .post("/auth/register")
        .send({ email: TEST_EMAIL, password: TEST_PASSWORD })
        .expect(409);
    });

    it("rejects short password with 400", async () => {
      await request(app.getHttpServer())
        .post("/auth/register")
        .send({ email: "new@test.local", password: "short" })
        .expect(400);
    });

    it("rejects invalid email with 400", async () => {
      await request(app.getHttpServer())
        .post("/auth/register")
        .send({ email: "not-an-email", password: TEST_PASSWORD })
        .expect(400);
    });
  });

  describe("POST /auth/login", () => {
    it("returns token pair for valid credentials", async () => {
      const res = await request(app.getHttpServer())
        .post("/auth/login")
        .send({ email: TEST_EMAIL, password: TEST_PASSWORD })
        .expect(200);

      expect(res.body).toMatchObject({
        accessToken: expect.any(String),
        refreshToken: expect.any(String),
      });
    });

    it("rejects wrong password with 401", async () => {
      await request(app.getHttpServer())
        .post("/auth/login")
        .send({ email: TEST_EMAIL, password: "wrongpassword" })
        .expect(401);
    });

    it("rejects unknown email with 401", async () => {
      await request(app.getHttpServer())
        .post("/auth/login")
        .send({ email: "nobody@test.local", password: TEST_PASSWORD })
        .expect(401);
    });
  });

  describe("POST /auth/refresh", () => {
    it("rotates the token pair", async () => {
      const res = await request(app.getHttpServer())
        .post("/auth/refresh")
        .send({ refreshToken })
        .expect(200);

      expect(res.body).toMatchObject({
        accessToken: expect.any(String),
        refreshToken: expect.any(String),
      });
      // New tokens differ from the originals
      expect(res.body.accessToken).not.toBe(accessToken);
      expect(res.body.refreshToken).not.toBe(refreshToken);

      // Update for downstream tests
      accessToken = res.body.accessToken;
      refreshToken = res.body.refreshToken;
    });

    it("rejects a replayed (already-rotated) refresh token with 401", async () => {
      // The old refreshToken was consumed in the previous test
      const originalRefresh = refreshToken; // save current
      // rotate once more to get a fresh pair
      const res = await request(app.getHttpServer())
        .post("/auth/refresh")
        .send({ refreshToken: originalRefresh })
        .expect(200);
      const rotated = res.body.refreshToken;

      // replaying the original (now consumed) token should fail
      await request(app.getHttpServer())
        .post("/auth/refresh")
        .send({ refreshToken: originalRefresh })
        .expect(401);

      refreshToken = rotated;
    });

    it("rejects a garbage token with 401", async () => {
      await request(app.getHttpServer())
        .post("/auth/refresh")
        .send({ refreshToken: "not.a.jwt" })
        .expect(401);
    });
  });

  describe("Protected routes", () => {
    it("rejects requests without a Bearer token with 401", async () => {
      await request(app.getHttpServer()).get("/sync/pull").expect(401);
    });

    it("rejects an expired / invalid access token with 401", async () => {
      await request(app.getHttpServer())
        .get("/sync/pull")
        .set("Authorization", "Bearer invalid.jwt.token")
        .expect(401);
    });
  });
});
