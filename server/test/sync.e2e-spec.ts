import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication, ValidationPipe } from "@nestjs/common";
import * as request from "supertest";
import { v4 as uuidv4 } from "uuid";
import { AppModule } from "src/app.module";
import { PrismaService } from "src/prisma/prisma.service";

const EMAIL = `sync-e2e-${Date.now()}@test.local`;
const PASSWORD = "Password123!";

async function login(app: INestApplication, email: string, password: string) {
  // Register then login so the test is self-contained.
  await request(app.getHttpServer())
    .post("/auth/register")
    .send({ email, password });
  const res = await request(app.getHttpServer())
    .post("/auth/login")
    .send({ email, password });
  return res.body.accessToken as string;
}

describe("Sync (e2e)", () => {
  let app: INestApplication;
  let prisma: PrismaService;
  let token: string;

  // IDs created during this suite, for cleanup.
  const planId = uuidv4();
  const planDayId = uuidv4();
  const planExerciseId = uuidv4();
  const sessionId = uuidv4();
  const sessionExerciseId = uuidv4();
  const loggedSetId = uuidv4();

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
    token = await login(app, EMAIL, PASSWORD);
  });

  afterAll(async () => {
    await prisma.user.deleteMany({
      where: { email: { startsWith: "sync-e2e-" } },
    });
    await app.close();
  });

  describe("POST /sync/push", () => {
    it("rejects unauthenticated requests", async () => {
      await request(app.getHttpServer())
        .post("/sync/push")
        .send({ records: [] })
        .expect(401);
    });

    it("accepts an empty records array", async () => {
      const res = await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({ records: [] })
        .expect(200);

      expect(res.body).toMatchObject({ cursor: expect.any(String) });
    });

    it("rejects a record with an unknown table", async () => {
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "unknown_table",
              id: uuidv4(),
              data: {},
              clientUpdatedAt: new Date().toISOString(),
            },
          ],
        })
        .expect(400);
    });

    it("pushes a full record hierarchy and returns a cursor", async () => {
      const now = new Date().toISOString();

      const records = [
        {
          table: "plans",
          id: planId,
          data: { name: "Push/Pull/Legs", currentDayIndex: 0 },
          clientUpdatedAt: now,
        },
        {
          table: "plan_days",
          id: planDayId,
          data: { planId, dayIndex: 0, name: "Push Day", isRest: false },
          clientUpdatedAt: now,
        },
        {
          table: "plan_exercises",
          id: planExerciseId,
          data: {
            planDayId,
            exerciseId: "bench-press",
            position: 0,
            targetSets: 4,
          },
          clientUpdatedAt: now,
        },
        {
          table: "sessions",
          id: sessionId,
          data: { planId, dayIndex: 0, startedAt: now, notes: "Felt strong" },
          clientUpdatedAt: now,
        },
        {
          table: "session_exercises",
          id: sessionExerciseId,
          data: { sessionId, exerciseId: "bench-press", position: 0 },
          clientUpdatedAt: now,
        },
        {
          table: "logged_sets",
          id: loggedSetId,
          data: {
            sessionExerciseId,
            setIndex: 0,
            metrics: { weight: 100, reps: 8 },
            isPr: true,
          },
          clientUpdatedAt: now,
        },
      ];

      const res = await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({ records })
        .expect(200);

      expect(res.body.cursor).toBeDefined();
      expect(new Date(res.body.cursor).getTime()).toBeGreaterThan(0);
    });
  });

  describe("GET /sync/pull", () => {
    it("rejects unauthenticated requests", async () => {
      await request(app.getHttpServer()).get("/sync/pull").expect(401);
    });

    it("returns all records when since=0", async () => {
      const res = await request(app.getHttpServer())
        .get("/sync/pull?since=1970-01-01T00:00:00.000Z")
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      expect(res.body.records).toBeInstanceOf(Array);
      expect(res.body.cursor).toBeDefined();

      const ids = res.body.records.map((r: any) => r.id);
      expect(ids).toContain(planId);
      expect(ids).toContain(planDayId);
      expect(ids).toContain(planExerciseId);
      expect(ids).toContain(sessionId);
      expect(ids).toContain(sessionExerciseId);
      expect(ids).toContain(loggedSetId);
    });

    it("returns table and data shape for a plan record", async () => {
      const res = await request(app.getHttpServer())
        .get("/sync/pull?since=1970-01-01T00:00:00.000Z")
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      const plan = res.body.records.find((r: any) => r.id === planId);
      expect(plan).toMatchObject({
        table: "plans",
        id: planId,
        data: { name: "Push/Pull/Legs", currentDayIndex: 0 },
        updatedAt: expect.any(String),
        deletedAt: null,
      });
    });

    it("returns no records when since is in the future", async () => {
      const future = new Date(Date.now() + 60_000).toISOString();
      const res = await request(app.getHttpServer())
        .get(`/sync/pull?since=${future}`)
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      expect(res.body.records).toHaveLength(0);
    });

    it("rejects an invalid since cursor with 400", async () => {
      await request(app.getHttpServer())
        .get("/sync/pull?since=not-a-date")
        .set("Authorization", `Bearer ${token}`)
        .expect(400);
    });
  });

  describe("Push/pull round-trip", () => {
    it("push records then pull returns them", async () => {
      // Fresh entity IDs for this sub-test
      const pid = uuidv4();
      const ts = new Date().toISOString();

      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "Round-trip plan", currentDayIndex: 0 },
              clientUpdatedAt: ts,
            },
          ],
        })
        .expect(200);

      // Pull with since just before the push
      const before = new Date(Date.now() - 2000).toISOString();
      const res = await request(app.getHttpServer())
        .get(`/sync/pull?since=${before}`)
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      const found = res.body.records.find((r: any) => r.id === pid);
      expect(found).toBeDefined();
      expect(found.data.name).toBe("Round-trip plan");
    });

    it("soft-delete: push deletedAt, pull returns it with deletedAt set", async () => {
      const pid = uuidv4();
      const ts = new Date().toISOString();

      // Create
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "To be deleted", currentDayIndex: 0 },
              clientUpdatedAt: ts,
            },
          ],
        })
        .expect(200);

      // Soft-delete
      const deleteTs = new Date().toISOString();
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "To be deleted", currentDayIndex: 0 },
              clientUpdatedAt: deleteTs,
              deletedAt: deleteTs,
            },
          ],
        })
        .expect(200);

      const before = new Date(Date.now() - 3000).toISOString();
      const res = await request(app.getHttpServer())
        .get(`/sync/pull?since=${before}`)
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      const found = res.body.records.find((r: any) => r.id === pid);
      expect(found).toBeDefined();
      expect(found.deletedAt).toBeTruthy();
    });
  });

  describe("Last-write-wins", () => {
    it("server keeps its version when client timestamp is older", async () => {
      const pid = uuidv4();
      const serverTs = new Date().toISOString();

      // Push "current" version
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "Current name", currentDayIndex: 0 },
              clientUpdatedAt: serverTs,
            },
          ],
        })
        .expect(200);

      // Push older version (clientUpdatedAt in the past)
      const olderTs = new Date(Date.now() - 60_000).toISOString();
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "Stale name", currentDayIndex: 1 },
              clientUpdatedAt: olderTs,
            },
          ],
        })
        .expect(200);

      // Pull: should still have the first (newer) version
      const res = await request(app.getHttpServer())
        .get("/sync/pull?since=1970-01-01T00:00:00.000Z")
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      const plan = res.body.records.find((r: any) => r.id === pid);
      expect(plan.data.name).toBe("Current name");
      expect(plan.data.currentDayIndex).toBe(0);
    });

    it("client wins when its timestamp is newer than the server version", async () => {
      const pid = uuidv4();
      const olderTs = new Date(Date.now() - 60_000).toISOString();

      // Push old version first
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "Old name", currentDayIndex: 0 },
              clientUpdatedAt: olderTs,
            },
          ],
        })
        .expect(200);

      // Use a clearly future timestamp so it is guaranteed to beat the server's updatedAt.
      const newerTs = new Date(Date.now() + 10_000).toISOString();
      await request(app.getHttpServer())
        .post("/sync/push")
        .set("Authorization", `Bearer ${token}`)
        .send({
          records: [
            {
              table: "plans",
              id: pid,
              data: { name: "Updated name", currentDayIndex: 2 },
              clientUpdatedAt: newerTs,
            },
          ],
        })
        .expect(200);

      const res = await request(app.getHttpServer())
        .get("/sync/pull?since=1970-01-01T00:00:00.000Z")
        .set("Authorization", `Bearer ${token}`)
        .expect(200);

      const plan = res.body.records.find((r: any) => r.id === pid);
      expect(plan.data.name).toBe("Updated name");
      expect(plan.data.currentDayIndex).toBe(2);
    });
  });
});
