import { execSync } from "child_process";

export default async function globalSetup() {
  process.env.DATABASE_URL =
    process.env.DATABASE_URL_TEST ??
    "postgresql://momentum:momentum@localhost:5433/momentum_test?schema=public";

  // Apply all migrations to the test database before the suite runs.
  execSync("npx prisma migrate deploy", {
    env: { ...process.env },
    stdio: "inherit",
  });
}
