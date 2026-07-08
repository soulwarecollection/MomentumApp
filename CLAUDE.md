# Momentum — Project Memory

> Drop this file at the repo root. Claude Code loads it automatically every
> session. Keep it high-signal and under ~200 lines. Visual/UX source of truth
> is `design/prototype.html` (the clickable prototype) — match its screens,
> flows, and tokens.

## Product

Momentum is a **modality-agnostic workout logger** for phones (iOS + Android).
Positioning: fast, **private-by-default**, frictionless between-set logging.
It is a *logger*, not an AI plan generator and not a notes app. Competitors:
Hevy, Strong, Jefit. Our wedge: truly modality-agnostic (strength / cardio /
bodyweight / timed) + the user owns and can export their data + a flexible,
rotation-based scheduler (not a weekday calendar).

## Tech stack (pin to these)

- **Flutter 3.44.x / Dart 3.12.x** (stable). Do NOT target Flutter 4.0 (unreleased).
- SDK constraint: `environment: { sdk: ^3.12.0 }`. Material 3, Impeller on.
- **State management: `flutter_bloc`** — Cubit for simple state, Bloc (events)
  for the logging session. No setState in feature code.
- **Navigation: `go_router`** (typed routes).
- **DI: `get_it` + `injectable`.**
- **Models: `freezed` + `json_serializable`** (immutable, union types for state).
- **Local DB (offline-first source of truth): `drift`** (SQLite).
- **Networking: `dio`** (only needed once cloud sync lands).
- **Errors: `fpdart`** — repositories return `Either<Failure, T>` (`TaskEither`
  for async). Define a sealed `Failure` hierarchy in core.
- **Charts: `fl_chart`.** Dates/units: `intl`.
- **IAP / entitlements: `purchases_flutter` (RevenueCat).**
- **Notifications (rest timer, reminders): `flutter_local_notifications`.**
- **Lints: `very_good_analysis`.** **Tests: `flutter_test`, `bloc_test`,
  `mocktail`, `integration_test`.**
- Always resolve **latest stable** compatible versions from pub.dev — do not
  hardcode old versions from training data; run `flutter pub outdated` to check.

## Backend (only when cloud sync / accounts are built — Pro feature)

- **NestJS (latest)** + **Prisma** + **PostgreSQL**, JWT auth (`passport-jwt`),
  DTO validation with `class-validator`/`class-transformer`, Dockerized.
- The MVP and the entire **Free tier ship with NO backend** — fully local.
  RevenueCat handles entitlements without our own server. Build the backend
  only for cross-device sync + backup (Pro).

## Architecture — feature-first Clean Architecture

```
lib/
  core/            theme, router, di, error (Failure), network, common widgets, utils
  features/
    <feature>/
      data/        models (freezed+json), datasources (drift dao + remote dio), repositories (impl)
      domain/      entities, repositories (abstract), usecases
      presentation/ bloc|cubit, pages, widgets
```

Features: `logging`, `routines` (plans/days/exercises), `schedule` (today +
rotation + next-workout), `progress` (analytics/history/heatmap), `library`,
`paywall` (pro gating), `sync` (account + sync — later), `settings`.

Rules:
- **Drift is the single source of truth.** UI streams from Drift (watch queries).
  Writes go to Drift first; sync pushes to backend off the critical path.
- **Flexible metric model:** a logged set stores a **map of metric→value**
  (e.g. `{weight: 82.5, reps: 8, extraReps: 2, halfReps: 0}` for strength;
  `{distanceKm: 5, timeMin: 30}` for cardio) — NOT hard columns. Persist as a
  typed JSON column or a `set_metrics` child table. This is the core data design.
- Each session belongs to a `{planId, dayIndex}` (nullable for freestyle).
- **Rotation cursor:** each plan has a `currentDayIndex` that advances when a
  session is **completed** (skip rest days) — never derived from the weekday.
  The "next workout" is `{planId, dayIndex, plannedDate?}` (nullable date).
- **Pro gating:** one `EntitlementCubit` fed by RevenueCat exposes `isPro`. A
  `ProGate` widget wraps gated UI and routes to the paywall. Gates: unlimited
  plans (free = 3), advanced analytics (volume balance, 6m/1y ranges), cloud
  sync, Apple Watch. **Never gate logging or data export** (privacy wedge).

## Design tokens (from the prototype — keep exact)

Implement as a Material 3 `ColorScheme` + a brand `ThemeExtension`.

- Fonts: **Space Grotesk** (display + all numerals, tabular figures) + **Inter** (UI).
- Light: primary `#FF4D4D`, bg `#F8F9FA`, surface `#FFFFFF`, text `#1A1A1A`,
  success/accent `#00C853`.
- Dark: primary `#00E5FF`, bg `#121212`, surface `#1E1E1E`, text `#E0E0E0`,
  achievement `#FFD600`, progress-green `#00E676`.
- Modality colors (theme-independent): push `#F5871F`, pull `#2E8BFF`,
  legs `#9B6BFF`, cardio `#14B8A6`. Radii: card 16, large 20, small 13.
- Respect `MediaQuery.disableAnimations` (reduced motion). Big tap targets in
  the logger (sweaty-hands ergonomics).

## Conventions

- Immutable state via `freezed`; name states `XxxState` with union variants.
- After any change to freezed models / drift tables, run:
  `dart run build_runner build --delete-conflicting-outputs`
  (use `watch` during active dev).
- Every Cubit/Bloc gets a `bloc_test`; repositories get unit tests with `mocktail`.
- Keep widgets dumb; logic in bloc/usecases. No business logic in widgets.
- `dart format .` and lint-clean (`very_good_analysis`) before considering done.
- Conventional commits. One feature slice per PR/working session.

## Common commands

```
flutter pub get
dart run build_runner watch --delete-conflicting-outputs
flutter test
flutter analyze
flutter run
```

## Working agreement for the agent

- Build **one vertical slice at a time** (data → domain → presentation), verify
  it runs and tests pass, then move on. Don't scaffold everything at once.
- Propose a short plan before large changes; wait for confirmation on schema
  or architecture decisions.
- When unsure about a current package version or API, check pub.dev rather than
  assuming. Prefer the official, maintained package.
