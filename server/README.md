# Momentum sync server

NestJS + Prisma + PostgreSQL backend for Momentum Pro's cross-device cloud
sync. JWT auth (register/login/refresh) plus push/pull sync endpoints using
last-write-wins conflict resolution.

## Local setup

```sh
cp .env.example .env   # then fill in real secrets
npm install
npx prisma generate
npx prisma migrate dev
npm run start:dev
```

Needs a running Postgres matching `DATABASE_URL` in `.env` — either
`docker compose up` (starts `postgres` + `postgres_test` + the API) or a local
Postgres install with matching `momentum`/`momentum_test` databases and a
`momentum` role.

## Commands

```sh
npm run build         # nest build
npm run lint          # eslint
npm test              # unit tests (none yet — e2e covers this API)
npm run test:e2e      # full e2e suite against DATABASE_URL_TEST
npx prisma migrate dev --name <name>   # new migration
```

## Deploying (Render + Neon, both free)

1. **Neon** (database) — [neon.tech](https://neon.tech), create a project.
   Neon gives you two connection strings on the dashboard:
   - **Pooled** (hostname contains `-pooler`) → `DATABASE_URL`
   - **Direct** (no `-pooler`) → `DIRECT_URL`

   Both need `?sslmode=require` appended if Neon's UI doesn't already include it.

2. **Render** (API) — [render.com](https://render.com), New → Blueprint, point
   it at this repo. It reads [`render.yaml`](../render.yaml) at the repo root
   and creates the `momentum-api` web service from `server/Dockerfile`
   automatically. Render will prompt for the env vars marked `sync: false` —
   paste in the two Neon URLs above plus generated values for
   `JWT_ACCESS_SECRET` / `JWT_REFRESH_SECRET` (e.g. `openssl rand -hex 32`).

3. On deploy, the Dockerfile's `CMD` runs `prisma migrate deploy` against
   `DIRECT_URL` before starting the server, so migrations apply automatically
   — nothing manual needed after the first deploy.

4. Render's free web services spin down after ~15 minutes idle; the first
   request after that takes 30-50s to wake back up. Fine pre-launch; revisit
   (e.g. Fly.io) once real users are hitting it at unpredictable times.

Health check: `GET /health` → `{"status":"ok"}` (used by Render and safe to
hit manually to confirm the service is up).
