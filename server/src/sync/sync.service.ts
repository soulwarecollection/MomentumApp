import {
  Injectable,
  BadRequestException,
  ForbiddenException,
} from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { SyncRecordDto } from "./dto/push.dto";

export interface SyncRecordOut {
  table: string;
  id: string;
  data: Record<string, unknown>;
  updatedAt: string;
  deletedAt: string | null;
}

export interface PushResult {
  cursor: string;
}

export interface PullResult {
  records: SyncRecordOut[];
  cursor: string;
}

@Injectable()
export class SyncService {
  constructor(private readonly prisma: PrismaService) {}

  // ── Push ─────────────────────────────────────────────────────────────────

  async push(records: SyncRecordDto[], userId: string): Promise<PushResult> {
    for (const record of records) {
      await this.applyRecord(record, userId);
    }
    return { cursor: new Date().toISOString() };
  }

  private async applyRecord(rec: SyncRecordDto, userId: string): Promise<void> {
    const clientTs = new Date(rec.clientUpdatedAt);
    const deletedAt = rec.deletedAt ? new Date(rec.deletedAt) : null;

    switch (rec.table) {
      case "plans":
        await this.upsertPlan(rec.id, rec.data, userId, clientTs, deletedAt);
        break;
      case "plan_days":
        await this.upsertPlanDay(rec.id, rec.data, userId, clientTs, deletedAt);
        break;
      case "plan_exercises":
        await this.upsertPlanExercise(
          rec.id,
          rec.data,
          userId,
          clientTs,
          deletedAt,
        );
        break;
      case "sessions":
        await this.upsertSession(rec.id, rec.data, userId, clientTs, deletedAt);
        break;
      case "session_exercises":
        await this.upsertSessionExercise(
          rec.id,
          rec.data,
          userId,
          clientTs,
          deletedAt,
        );
        break;
      case "logged_sets":
        await this.upsertLoggedSet(
          rec.id,
          rec.data,
          userId,
          clientTs,
          deletedAt,
        );
        break;
    }
  }

  // LWW helper: returns true if the client write should be applied.
  private shouldApply(existingUpdatedAt: Date | null, clientTs: Date): boolean {
    if (!existingUpdatedAt) return true;
    return clientTs > existingUpdatedAt;
  }

  private async upsertPlan(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const existing = await this.prisma.plan.findUnique({ where: { id } });
    if (existing && existing.userId !== userId) throw new ForbiddenException();
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      userId,
      name: String(data.name ?? ""),
      currentDayIndex: Number(data.currentDayIndex ?? 0),
      deletedAt,
    };

    await this.prisma.plan.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  private async upsertPlanDay(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const planId = String(data.planId ?? "");
    await this.assertPlanOwner(planId, userId);

    const existing = await this.prisma.planDay.findUnique({ where: { id } });
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      planId,
      dayIndex: Number(data.dayIndex ?? 0),
      name: data.name != null ? String(data.name) : null,
      isRest: Boolean(data.isRest ?? false),
      deletedAt,
    };

    await this.prisma.planDay.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  private async upsertPlanExercise(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const planDayId = String(data.planDayId ?? "");
    await this.assertPlanDayOwner(planDayId, userId);

    const existing = await this.prisma.planExercise.findUnique({
      where: { id },
    });
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      planDayId,
      exerciseId: String(data.exerciseId ?? ""),
      position: Number(data.position ?? 0),
      targetSets: data.targetSets != null ? Number(data.targetSets) : null,
      targetMetrics: (data.targetMetrics as object) ?? null,
      deletedAt,
    };

    await this.prisma.planExercise.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  private async upsertSession(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const existing = await this.prisma.session.findUnique({ where: { id } });
    if (existing && existing.userId !== userId) throw new ForbiddenException();
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      userId,
      planId: data.planId != null ? String(data.planId) : null,
      dayIndex: data.dayIndex != null ? Number(data.dayIndex) : null,
      startedAt: new Date(String(data.startedAt ?? new Date().toISOString())),
      completedAt:
        data.completedAt != null ? new Date(String(data.completedAt)) : null,
      notes: data.notes != null ? String(data.notes) : null,
      deletedAt,
    };

    await this.prisma.session.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  private async upsertSessionExercise(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const sessionId = String(data.sessionId ?? "");
    await this.assertSessionOwner(sessionId, userId);

    const existing = await this.prisma.sessionExercise.findUnique({
      where: { id },
    });
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      sessionId,
      exerciseId: String(data.exerciseId ?? ""),
      position: Number(data.position ?? 0),
      deletedAt,
    };

    await this.prisma.sessionExercise.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  private async upsertLoggedSet(
    id: string,
    data: Record<string, unknown>,
    userId: string,
    clientTs: Date,
    deletedAt: Date | null,
  ) {
    const sessionExerciseId = String(data.sessionExerciseId ?? "");
    await this.assertSessionExerciseOwner(sessionExerciseId, userId);

    const existing = await this.prisma.loggedSet.findUnique({ where: { id } });
    if (!this.shouldApply(existing?.updatedAt ?? null, clientTs)) return;

    const payload = {
      sessionExerciseId,
      setIndex: Number(data.setIndex ?? 0),
      metrics: (data.metrics as object) ?? {},
      isPr: Boolean(data.isPr ?? false),
      completedAt:
        data.completedAt != null ? new Date(String(data.completedAt)) : null,
      deletedAt,
    };

    await this.prisma.loggedSet.upsert({
      where: { id },
      create: { id, ...payload },
      update: payload,
    });
  }

  // ── Pull ─────────────────────────────────────────────────────────────────

  async pull(since: string, userId: string): Promise<PullResult> {
    const sinceDate = since ? new Date(since) : new Date(0);
    if (isNaN(sinceDate.getTime()))
      throw new BadRequestException("Invalid since cursor");

    const filter = { gt: sinceDate };
    const records: SyncRecordOut[] = [];

    const [
      plans,
      planDays,
      planExercises,
      sessions,
      sessionExercises,
      loggedSets,
    ] = await Promise.all([
      this.prisma.plan.findMany({
        where: { userId, updatedAt: filter },
      }),
      this.prisma.planDay.findMany({
        where: { plan: { userId }, updatedAt: filter },
      }),
      this.prisma.planExercise.findMany({
        where: { planDay: { plan: { userId } }, updatedAt: filter },
      }),
      this.prisma.session.findMany({
        where: { userId, updatedAt: filter },
      }),
      this.prisma.sessionExercise.findMany({
        where: { session: { userId }, updatedAt: filter },
      }),
      this.prisma.loggedSet.findMany({
        where: { sessionExercise: { session: { userId } }, updatedAt: filter },
      }),
    ]);

    for (const p of plans) {
      records.push({
        table: "plans",
        id: p.id,
        data: {
          userId: p.userId,
          name: p.name,
          currentDayIndex: p.currentDayIndex,
        },
        updatedAt: p.updatedAt.toISOString(),
        deletedAt: p.deletedAt?.toISOString() ?? null,
      });
    }

    for (const pd of planDays) {
      records.push({
        table: "plan_days",
        id: pd.id,
        data: {
          planId: pd.planId,
          dayIndex: pd.dayIndex,
          name: pd.name,
          isRest: pd.isRest,
        },
        updatedAt: pd.updatedAt.toISOString(),
        deletedAt: pd.deletedAt?.toISOString() ?? null,
      });
    }

    for (const pe of planExercises) {
      records.push({
        table: "plan_exercises",
        id: pe.id,
        data: {
          planDayId: pe.planDayId,
          exerciseId: pe.exerciseId,
          position: pe.position,
          targetSets: pe.targetSets,
          targetMetrics: pe.targetMetrics,
        },
        updatedAt: pe.updatedAt.toISOString(),
        deletedAt: pe.deletedAt?.toISOString() ?? null,
      });
    }

    for (const s of sessions) {
      records.push({
        table: "sessions",
        id: s.id,
        data: {
          userId: s.userId,
          planId: s.planId,
          dayIndex: s.dayIndex,
          startedAt: s.startedAt.toISOString(),
          completedAt: s.completedAt?.toISOString() ?? null,
          notes: s.notes,
        },
        updatedAt: s.updatedAt.toISOString(),
        deletedAt: s.deletedAt?.toISOString() ?? null,
      });
    }

    for (const se of sessionExercises) {
      records.push({
        table: "session_exercises",
        id: se.id,
        data: {
          sessionId: se.sessionId,
          exerciseId: se.exerciseId,
          position: se.position,
        },
        updatedAt: se.updatedAt.toISOString(),
        deletedAt: se.deletedAt?.toISOString() ?? null,
      });
    }

    for (const ls of loggedSets) {
      records.push({
        table: "logged_sets",
        id: ls.id,
        data: {
          sessionExerciseId: ls.sessionExerciseId,
          setIndex: ls.setIndex,
          metrics: ls.metrics,
          isPr: ls.isPr,
          completedAt: ls.completedAt?.toISOString() ?? null,
        },
        updatedAt: ls.updatedAt.toISOString(),
        deletedAt: ls.deletedAt?.toISOString() ?? null,
      });
    }

    return { records, cursor: new Date().toISOString() };
  }

  // ── Ownership guards ──────────────────────────────────────────────────────

  private async assertPlanOwner(planId: string, userId: string) {
    const plan = await this.prisma.plan.findUnique({ where: { id: planId } });
    if (!plan) throw new BadRequestException(`Plan ${planId} not found`);
    if (plan.userId !== userId) throw new ForbiddenException();
  }

  private async assertPlanDayOwner(planDayId: string, userId: string) {
    const day = await this.prisma.planDay.findUnique({
      where: { id: planDayId },
      include: { plan: true },
    });
    if (!day) throw new BadRequestException(`PlanDay ${planDayId} not found`);
    if (day.plan.userId !== userId) throw new ForbiddenException();
  }

  private async assertSessionOwner(sessionId: string, userId: string) {
    const session = await this.prisma.session.findUnique({
      where: { id: sessionId },
    });
    if (!session)
      throw new BadRequestException(`Session ${sessionId} not found`);
    if (session.userId !== userId) throw new ForbiddenException();
  }

  private async assertSessionExerciseOwner(
    sessionExerciseId: string,
    userId: string,
  ) {
    const se = await this.prisma.sessionExercise.findUnique({
      where: { id: sessionExerciseId },
      include: { session: true },
    });
    if (!se)
      throw new BadRequestException(
        `SessionExercise ${sessionExerciseId} not found`,
      );
    if (se.session.userId !== userId) throw new ForbiddenException();
  }
}
