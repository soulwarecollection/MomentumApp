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

In debug builds, **You → Developer → Debug · Momentum Pro** toggles a persisted
local entitlement for testing every gate without contacting a store.

## Development

```sh
flutter pub get
dart run build_runner build
flutter analyze
flutter test
```
