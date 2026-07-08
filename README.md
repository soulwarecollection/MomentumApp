# Momentum

A fast, private, modality-agnostic workout logger built with Flutter.

## RevenueCat configuration

Create a RevenueCat entitlement named `pro` and a current offering containing
the standard monthly, annual, and lifetime package types. Then run the app with
the public RevenueCat SDK key supplied at compile time:

```sh
flutter run --dart-define=REVENUECAT_API_KEY=your_public_sdk_key
```

For separate store projects, platform-specific values override the common key:

```sh
flutter run \
  --dart-define=REVENUECAT_IOS_API_KEY=appl_your_key \
  --dart-define=REVENUECAT_ANDROID_API_KEY=goog_your_key
```

Use `--dart-define=REVENUECAT_ENTITLEMENT_ID=your_entitlement` when the
entitlement identifier is not `pro`. If no key is supplied, the app remains
fully usable on the Free tier and checkout is disabled gracefully.

Debug builds show a local Pro preview switch under **You → Developer & QA**.
To include the same switch in an internal profile or release build, compile it
with:

```sh
flutter build ipa --dart-define=ENABLE_PRO_TESTER_SWITCH=true
```

Use that flag only for developer and tester builds. Store production builds
omit the switch and ignore any previously saved local override.

## Development

```sh
flutter pub get
dart run build_runner build
flutter analyze
flutter test
```

## Backend (sync server)

See [server/README.md](server/README.md) — NestJS + Prisma + PostgreSQL. Requires a local
Postgres instance (or `docker compose up` from `server/`) and a `server/.env`
copied from `server/.env.example`.

## Privacy policy

Hosted via GitHub Pages from [`docs/`](docs/index.html) — enable it once under
Settings → Pages → Source: Deploy from a branch → `main` / `docs`.
