# Momentum — Build Playbook (prompts for Claude in VS Code)

A sequenced set of prompts to develop the app with Claude Code / the Claude
VS Code extension. Order matters — each phase depends on the previous one.

## How to use this

1. Create the repo folder. Put `CLAUDE.md` at the root and the clickable
   prototype at `design/prototype.html`. These give Claude the full context.
2. Open the folder in VS Code and start Claude. Run `/init` once so it indexes
   the project and confirms it has read `CLAUDE.md`.
3. Paste prompts **one at a time, in order**. After each, review the diff, run
   the app/tests, and only then continue. Don't batch phases.
4. Prefer **plan-first**: for any big step, start with *"Plan this, don't write
   code yet"*, review, then *"go ahead"*.
5. After model/DB changes, always run
   `dart run build_runner build --delete-conflicting-outputs`.
6. Keep slices small. Ask for tests with every bloc and repository.

Tip: end larger prompts with *"Then run `flutter analyze` and `flutter test`
and fix anything that fails before reporting back."*

---

## Phase 0 — Project & tooling

> Create a new Flutter app named `momentum` targeting Flutter 3.44 / Dart 3.12
> (stable), iOS + Android only for now. Set the package id and app name. Add and
> wire up these dependencies at their latest stable versions compatible with
> this SDK (check pub.dev, don't guess versions): flutter_bloc, go_router,
> get_it, injectable, freezed + freezed_annotation, json_serializable +
> json_annotation, drift + drift_flutter + sqlite3_flutter_libs, fpdart, fl_chart,
> intl, purchases_flutter, flutter_local_notifications, equatable (only if
> needed). Dev deps: build_runner, injectable_generator, drift_dev,
> very_good_analysis, bloc_test, mocktail, integration_test. Configure
> very_good_analysis in analysis_options.yaml. Set up the Space Grotesk + Inter
> fonts in pubspec (I'll provide the font files / use google_fonts). Confirm the
> app builds and runs a blank screen.

## Phase 1 — Architecture scaffolding

> Set up the feature-first Clean Architecture skeleton described in CLAUDE.md.
> Create `lib/core/` with: a `Failure` sealed class hierarchy (with fpdart),
> a `get_it` + `injectable` DI container (`configureDependencies()` called in
> main), a `go_router` config with placeholder routes for the five tabs
> (today, plans, progress, you) plus logger/library/detail routes, and an
> empty `lib/features/` tree. Wire DI and the router into `main.dart` behind a
> root `MaterialApp.router`. No business logic yet — just the wiring, compiling
> and running with empty placeholder pages and a working bottom nav.

## Phase 2 — Design system

> Build the theme layer in `lib/core/theme/`. Create light and dark
> `ColorScheme`s from the exact tokens in CLAUDE.md, plus a `BrandTokens`
> `ThemeExtension` holding the modality colors, radii, and the achievement /
> progress-green accents. Use Space Grotesk for display + all numeric text
> (tabular figures) and Inter for UI. Expose `AppTheme.light` / `AppTheme.dark`
> and wire a theme-mode Cubit (persisted) so the app can switch. Add a few
> reusable core widgets that match the prototype: a primary CTA button, a card
> container, a stat tile, and a segmented control. Show them on a temporary
> `/styleguide` page so I can eyeball both themes against `design/prototype.html`.

## Phase 3 — Data layer foundation (the most important design step)

> Implement the Drift database in `lib/core/db/` (or a `database` feature) as the
> offline-first source of truth. Tables: `plans` (id, name, isActive,
> currentDayIndex, createdAt, updatedAt, deletedAt nullable for soft-delete),
> `plan_days` (id, planId, orderIndex, focus, isRest), `plan_exercises`
> (id, planDayId, orderIndex, name, equipment, targetSets, scheme, target),
> `sessions` (id, planId nullable, dayIndex nullable, focus, startedAt, endedAt,
> durationSeconds, note, updatedAt, deletedAt), `session_exercises`
> (id, sessionId, orderIndex, name, equipment, modality), and `logged_sets`
> (id, sessionExerciseId, orderIndex, modality, metrics — a typed JSON column
> holding the flexible metric map, isDone, createdAt). Add the freezed entities
> + mappers. Implement DAOs with **watch** queries for reactive UI. Write unit
> tests for one DAO. Explain the flexible-metric JSON shape per modality in a
> short doc comment. Run build_runner.

## Phase 4 — Routines feature (first full vertical slice)

> Build the `routines` feature end to end as the reference slice for our
> architecture: domain (Plan/Day/Exercise entities, `RoutinesRepository`
> abstract, usecases for create/duplicate/delete/setActive plan and
> add/edit/delete/reorder day & exercise), data (`RoutinesRepositoryImpl` over
> the Drift DAOs returning `Either<Failure, T>`), presentation (a `PlansCubit`
> listing plans from a watch stream, and a `PlanEditorCubit`). Build the Plans
> list page and the Plan editor page (days + exercises CRUD with the
> equipment / sets / scheme / target fields) to match the prototype. Add
> `bloc_test`s for both cubits and a repository unit test. Verify CRUD persists
> across app restarts.

## Phase 5 — Logging feature (the core screen)

> Build the `logging` feature — this is the heart of the app, match the
> prototype's inline scrollable session exactly. Domain: a `WorkoutSession`
> aggregate (ordered exercises, each with editable set rows of flexible
> metrics), `LoggingRepository` to start a session from a plan day or freestyle
> and persist sets. Presentation: a **`SessionBloc`** (events: startSession,
> setRowValue, stepRowValue, toggleRowDone, addSet, removeSet, reorderExercise,
> toggleExerciseExpanded, addAdhocExercise, finishSession). UI: the scrollable
> list of collapsible exercise cards; the active card shows tap-to-type weight
> & reps fields (numeric keyboard) with +/- steppers, a done toggle, remove,
> "+ Add set", and an expandable extra/half-rep detail. Include: the session
> **stopwatch** (idle until first input or manual tap, pausable — persist a
> start timestamp, not a tick count), a **rest timer** sheet (±15s / skip /
> up-next) using a background-safe timer, **PR detection** on a completed set
> with a celebration, and **exercise reordering**. Use `ReorderableListView` for
> a proper drag handle. Add `bloc_test`s covering log/edit/remove/reorder and PR
> detection. On finish, write the session to Drift and advance the plan's
> rotation cursor.

## Phase 6 — Schedule / Today feature

> Build the `schedule` feature and the Today screen to match the prototype.
> Domain: a `NextWorkout` value (`planId`, `dayIndex`, `plannedDate?`) and the
> rotation logic — `advanceCursor` skips rest days; completing a session bumps
> the source plan's cursor and proposes the next day with an unset date.
> Presentation: a `TodayCubit` that exposes the next workout (plan, day focus,
> date label, exercise preview) and a `SchedulerCubit`. UI: the "Next workout"
> card with a tappable date chip; a **scheduler sheet** to pick When (today /
> future date — use a real date picker), Plan (any plan), and Which day (with
> the next-in-rotation pre-selected, overridable); plus the rotation strip with
> the cursor marked NEXT. Persist `NextWorkout`. Wire "Start workout" into the
> logging feature. Tests for the cursor advance + scheduler.

## Phase 7 — Progress & History

> Build the `progress` feature. Compute analytics from Drift sessions: estimated
> 1RM trend, weekly volume, per-exercise top-set trend, PRs, and the weekly
> volume distribution (push/pull/legs). Use `fl_chart` for the smoothed trend
> area chart with range toggle, and build the consistency **heatmap** (last 12
> weeks) from session dates. Add the session-detail, exercise-detail, and
> PR-detail pages, and a History page (heatmap + session list). Match the
> prototype's visuals. Keep all derivations in usecases with unit tests so the
> charts stay dumb.

## Phase 8 — Library

> Build the `library` feature: a searchable, modality-filterable exercise
> catalog backed by a seeded Drift table (seed common exercises on first run),
> reachable from the Log sheet and from "Browse exercises". Tapping an exercise
> opens its detail (history + trend) and offers "Log this exercise" into the
> logging feature. Cubit + tests.

## Phase 9 — Monetization (Free / Pro)

> Add the `paywall` feature and Pro gating per CLAUDE.md. Integrate RevenueCat
> (`purchases_flutter`): an `EntitlementCubit` exposing `isPro` from customer
> info, configured with the API key via `--dart-define`. Build a `ProGate`
> widget and an `requirePro()` flow that opens the paywall. Apply gates:
> unlimited plans (free = 3, show usage + block the 4th), advanced analytics
> (volume balance + 6m/1y ranges), cloud sync, Apple Watch — and **never** gate
> logging or export. Build the paywall page matching the prototype with three
> products (monthly / annual / lifetime) using the configured RevenueCat
> offerings. Add a debug-only "toggle Pro" for local testing. Tests for the
> gating logic.

## Phase 10 — Backend (NestJS) — only when adding cloud sync

> Scaffold a NestJS backend in `/server` (latest stable). Set up Prisma +
> PostgreSQL with models mirroring the client sync surface (users, plans,
> plan_days, plan_exercises, sessions, session_exercises, logged_sets — each
> with `updatedAt` and soft-delete `deletedAt`). Add JWT auth
> (register/login/refresh) with passport-jwt and bcrypt, DTO validation via
> class-validator. Implement a **sync controller** with two endpoints:
> `POST /sync/push` (accepts changed records since the client's last cursor) and
> `GET /sync/pull?since=<cursor>` (returns records changed after the cursor),
> using `updatedAt` watermarks and last-write-wins per record. Dockerize
> (Dockerfile + docker-compose with Postgres). Add e2e tests for auth + a
> push/pull round-trip.

## Phase 11 — Sync integration (client)

> In the app, add a `sync` feature: a remote datasource (`dio`) for the NestJS
> auth + sync endpoints, an account flow (sign in / out), and a `SyncService`
> that runs offline-first — write to Drift first, then push/pull deltas using a
> stored cursor, reconciling with last-write-wins and honoring soft-deletes.
> Trigger sync on app resume and after finishing a workout, with retry/backoff.
> Surface sync status in Settings. Gate the whole feature behind Pro
> (EntitlementCubit). Keep the Free, offline experience fully intact when signed
> out. Tests for the reconcile logic.

## Phase 12 — Polish, a11y, notifications

> Pass over the app for production feel: empty states, error states (from the
> `Failure` types), loading skeletons, haptics on log/PR, reduced-motion
> support, large-text / dynamic type, and semantic labels for accessibility.
> Add `flutter_local_notifications` for the rest timer and an optional
> "schedule your next workout" reminder. Verify both themes against the
> prototype on a small and large device.

## Phase 13 — Testing, CI, release

> Add a golden test for the logging screen and an `integration_test` covering
> the core flow (start → log sets → finish → see it in history). Set up CI
> (GitHub Actions: format check, analyze, test on every PR). Configure app
> icons, splash, flavors (dev/prod) via --dart-define, and prepare store
> metadata. Generate a privacy manifest reflecting "private by default, data
> exportable, sync is opt-in Pro." Produce a release checklist.

---

## Cross-cutting prompts (use anytime)

- **Refactor check:** *"Review the `<feature>` feature against CLAUDE.md's
  architecture and conventions. List deviations and fix them, smallest diffs
  first."*
- **Test backfill:** *"Add bloc_test coverage for `<Bloc>` for every event,
  including edge cases (empty session, removing the last set, reorder bounds)."*
- **Dependency hygiene:** *"Run `flutter pub outdated`, propose safe upgrades,
  apply them, run build_runner and the full test suite, fix breakages."*
- **Keep memory current:** *"Update CLAUDE.md to reflect the decisions we just
  made — keep it under 200 lines and high-signal."*
- **Performance:** *"Profile the logging screen for jank; ensure Drift watch
  queries aren't rebuilding the whole list; add `const`, keys, and selective
  rebuilds where needed."*
