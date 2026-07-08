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
