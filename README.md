# Flavor Rush

A Flutter food delivery app featuring shop browsing, search, filter/sort, and a detailed shop view. Built as a technical assessment for Rightware.

---

## Requirements

- Flutter `>=3.10.0`
- Dart SDK `>=3.0.0 <4.0.0`
- A valid `.env` file (see [Configuration](#configuration))

---

## Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd rightware_test
```

### 2. Configure environment variables

Copy the example file and fill in your credentials:

```bash
cp .env.example .env
```

Open `.env` and set the required value:

```env
SECRET_KEY=your_secret_key_here
```

> The app will throw a clear assertion error at startup if `SECRET_KEY` is missing or empty.

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
# Debug mode
flutter run

# Specific device
flutter run -d <device-id>

# Release mode
flutter run --release
```

---

## Project Structure

```
lib/
├── app/                        # Root MaterialApp, theme & locale wiring
├── core/
│   ├── bloc/                   # Event transformers (debounce)
│   ├── config/                 # EnvConfig — typed .env access
│   ├── error/                  # Failures & exceptions
│   ├── localization/           # AppLocalizations (EN + AR)
│   ├── network/                # NetworkFacade (Dio wrapper)
│   ├── theme/                  # AppColors, AppDecorations, AppTextStyles
│   └── widgets/                # Shared atomic widgets
├── features/
│   ├── authentication/         # Login, Sign-up, OTP, Reset Password
│   ├── home/                   # Home feed, categories, promos, food sections
│   ├── shops/                  # Shop listing, search/filter/sort, shop details
│   └── splash/                 # Animated splash screen
└── injection_container.dart    # GetIt dependency registration
```

Each feature follows Clean Architecture:

```
feature/
├── data/
│   ├── data_sources/           # Remote API calls
│   ├── models/                 # JSON → entity mappers
│   └── repositories/           # Repository implementations
├── domain/
│   ├── entities/               # Pure Dart models
│   ├── repositories/           # Abstract interfaces
│   └── use_cases/              # Single-responsibility business logic
└── presentation/
    ├── bloc/                   # BLoC events, states, bloc
    ├── screens/                # Screen widgets
    └── widgets/                # Feature-scoped reusable widgets
```

---

## Architecture & Key Decisions

### State Management — BLoC

All shop state is managed by `ShopBloc` which handles:

| Event | Description |
|---|---|
| `FetchShops` | Loads shops from the API |
| `SearchShops` | Filters by name (debounced 500 ms via RxDart) |
| `SortShops` | Sorts by ETA, min order, alphabetical, delivery fee |
| `ToggleOpenOnly` | Filters to open shops only |
| `ClearFilters` | Resets all filters and sort |

Each screen (`HomeScreen`, `AllShopsScreen`) owns an independent `ShopBloc` instance created via a GetIt factory. Navigating to `AllShopsScreen` always triggers a fresh API fetch — there is intentionally no cross-screen cache at this stage.

### Dependency Injection — GetIt

Registered in `injection_container.dart`:

| Registration | Lifetime |
|---|---|
| `NetworkFacadeInterface` | Singleton |
| `ShopRemoteDataSource` | Lazy singleton |
| `ShopRepository` | Lazy singleton |
| `FilterShopsUseCase`, `SortShopsUseCase` | Lazy singleton (stateless) |
| `ShopBloc` | Factory (fresh instance per screen) |

### Localization

Full bilingual support (English / Arabic) via a custom `AppLocalizations` class with a `context.tr('key')` extension method. The locale is managed at the `MyApp` root level via `MyApp.setLocale(context, locale)`.

RTL layout is handled per-widget using `Localizations.localeOf(context).languageCode == 'ar'` to flip icons and text alignment where Flutter's automatic RTL mirroring is insufficient.

### Theming

Light and dark themes are fully supported. Each widget reads `Theme.of(context).brightness` directly inside its own `build()` method — theme values are never stored as constructor parameters to avoid stale colors on live theme switches.

---

## API

| Field | Value |
|---|---|
| Endpoint | `https://api.orianosy.com/shop/test/find/all/shop` |
| Auth header | `secretKey: <SECRET_KEY>` |
| Query param | `deviceKind: android` |

The secret key is loaded from `.env` via `EnvConfig.secretKey`.

---

## Assumptions & Trade-offs

| Area | Decision | Reason |
|---|---|---|
| **No data caching** | Each screen fetches fresh data on load | Kept simple for the assessment scope; a production app would add a TTL cache in the repository layer |
| **Independent BLoC per screen** | `HomeScreen` and `AllShopsScreen` each own their own `ShopBloc` | Avoids shared-state complexity; trade-off is one extra network call on navigation |
| **Dummy home content** | Categories, promos, popular/trending sections use local `DummyData` | These endpoints were out of scope; data is structured to be swapped with real API responses |
| **Auth is UI-only** | Login/Sign-up screens have no real backend integration | Auth flow was not part of the assessment scope |
| **`deviceKind` hardcoded to `'android'`** | Always sends `android` in the API query param | Platform detection was out of scope; production code should use `Platform.isAndroid` |
| **Test API URL** | The endpoint contains `/test/` in the path | Used the provided test endpoint as-is; the production URL should be an env variable |
| **`ShopEmpty` loses filter metadata** | When a search or open-only filter yields zero results, active sort/filter state is lost | Known limitation identified during review; fix would be to carry filter metadata inside `ShopEmpty` |

---

## Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | BLoC state management |
| `get_it` | Service locator / dependency injection |
| `dartz` | Functional `Either` monad for error handling |
| `dio` | HTTP client |
| `cached_network_image` | Network image loading with cache |
| `google_fonts` | Typography |
| `flutter_dotenv` | `.env` file loading |
| `rxdart` | `debounceTransformer` for search input |
| `url_launcher` | Phone dialer (`tel:` URI) from shop details screen |
| `shared_preferences` | Local key-value storage |
| `flutter_secure_storage` | Secure token storage |
| `shimmer` | Loading skeleton animations |
| `equatable` | Value equality for BLoC states and events |
| `intl` | Localization/internationalization support |

---

## Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

> Ensure `.env` is present in the project root before building — it is bundled as a Flutter asset.