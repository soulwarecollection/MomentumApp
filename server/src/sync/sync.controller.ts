import {
  Controller,
  Post,
  Get,
  Body,
  Query,
  UseGuards,
  Req,
  HttpCode,
  HttpStatus,
} from "@nestjs/common";
import { Request } from "express";
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";
import { SyncService } from "./sync.service";
import { PushDto } from "./dto/push.dto";

interface AuthenticatedRequest extends Request {
  user: { userId: string; email: string };
}

@Controller("sync")
@UseGuards(JwtAuthGuard)
export class SyncController {
  constructor(private readonly sync: SyncService) {}

  @Post("push")
  @HttpCode(HttpStatus.OK)
  push(@Body() dto: PushDto, @Req() req: AuthenticatedRequest) {
    return this.sync.push(dto.records, req.user.userId);
  }

  @Get("pull")
  pull(@Query("since") since: string = "", @Req() req: AuthenticatedRequest) {
    return this.sync.pull(since, req.user.userId);
  }
}
