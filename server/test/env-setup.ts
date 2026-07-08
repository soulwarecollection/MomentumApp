// Runs in each Jest worker before tests execute — sets the test DB URL.
process.env.DATABASE_URL =
  process.env.DATABASE_URL_TEST ??
  "postgresql://momentum:momentum@localhost:5433/momentum_test?schema=public";
