import {
  IsString,
  IsIn,
  IsISO8601,
  IsOptional,
  IsObject,
  ValidateNested,
  IsArray,
} from "class-validator";
import { Type } from "class-transformer";

export const SYNC_TABLES = [
  "plans",
  "plan_days",
  "plan_exercises",
  "sessions",
  "session_exercises",
  "logged_sets",
] as const;

export type SyncTable = (typeof SYNC_TABLES)[number];

export class SyncRecordDto {
  @IsIn(SYNC_TABLES)
  table: SyncTable;

  @IsString()
  id: string;

  @IsObject()
  data: Record<string, unknown>;

  // Client's logical timestamp — used for last-write-wins comparison.
  @IsISO8601()
  clientUpdatedAt: string;

  @IsISO8601()
  @IsOptional()
  deletedAt?: string | null;
}

export class PushDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SyncRecordDto)
  records: SyncRecordDto[];
}
