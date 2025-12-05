# Union Shop

Flutter e-commerce: 13 pages, 67 tests, Firebase, Material Design 3

[![Flutter](https://img.shields.io/badge/Flutter-3.5+-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-v3-orange.svg)](https://firebase.google.com/)
[![Tests](https://img.shields.io/badge/Tests-67%2F67-brightgreen.svg)](#testing)

## Features

- **Homepage:** Product carousel with featured items
- **Shop:** 8 product categories, 5 sort options (price, name, newest, etc.)
- **Search:** Full-text product search
- **Cart:** Add/remove items, quantity management, persistent storage
- **Checkout:** Email/password auth via Firebase, order confirmation page
- **Personalization:** User profile, saved preferences
- **Info Pages:** About, terms, refund policy, Print Shack details
- **Responsive:** Mobile-first design, 900px+ breakpoint

## Tech Stack

- **Frontend:** Flutter 3.5.4, Dart 3.5.4
- **Backend:** Firebase Core 3.6.0, Firestore 5.4.4, Auth 5.3.1, Google Sign-In 6.2.2
- **State:** Singleton CartService (ChangeNotifier)
- **Testing:** flutter_test, fake_cloud_firestore 3.0.3, firebase_auth_mocks 0.14.1

## Architecture

**Design Patterns:**

- **Singleton:** CartService manages global cart state
- **Repository:** ProductRepository abstracts Firestore queries
- **Factory:** Product.fromMap() handles data serialization
- **State Management:** ChangeNotifier for reactive UI updates

**File Structure:**

```text
lib/
├── pages/      # 13 screens (home, shop, cart, checkout, auth, etc.)
├── widgets/    # 4 reusable components (product_tile, carousel, etc.)
├── services/   # CartService (singleton), ProductRepository (Firestore)
├── models/     # Product (with Firestore serialization)
└── constants.dart  # App colors, routing, text constants
```

## Project Structure

| Component | Details |
|-----------|---------|
| **Pages (13)** | home, shop, product, cart, checkout_success, search, personalization, sign_in, about, about_print_shack, terms_and_conditions, refund_policy, sale |
| **Widgets (4)** | product_tile, product_grid, hero_carousel, footer_subscribe_box |
| **Services** | CartService (singleton), ProductRepository (Firestore) |
| **Models** | Product (fromMap/toMap for Firestore) |

## Setup

**Prerequisites:** Flutter 3.5.4+, Dart 3.5.4+, Firebase project

```bash
git clone <repo-url>
cd union_shop
flutter pub get
flutterfire configure
flutter run
```

## Firebase

**Products Collection:**

```json
{
  "title": "Product",
  "imageUrl": "https://...",
  "price": 19.99,
  "slug": "product-slug",
  "subtitle": "Description",
  "collections": ["clothing", "featured"],
  "category": "clothing"
}
```

**Required Setup:**

1. Enable Email/Password authentication in Firebase Console
2. Create Firestore database with regional tier
3. Add Web, Android, iOS apps to Firebase project
4. Run `flutterfire configure` to auto-generate `lib/firebase_options.dart`
5. Upload products to `/products` collection (see schema above)

**Security Rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /products/{document=**} { allow read: if true; }
  }
}
```

## Testing

**67 Passing Tests** across 20 files:

- **Pages (13 tests):** UI rendering, navigation, user interactions
- **Widgets (3 tests):** product_tile, product_grid, hero_carousel
- **Services (2 tests):** CartService (add/remove/update), ProductRepository (query mocking)
- **Models (1 test):** Product serialization (fromMap/toMap)
- **Integration (1 test):** End-to-end user flow

```bash
flutter test                              # All
flutter test test/home_page_test.dart    # Specific
flutter test --coverage                   # Coverage
```

**Infrastructure:** Firebase mocking, test_helper.dart, 50+ test products

## Build & Run

```bash
flutter run              # Debug
flutter run -d chrome    # Web
flutter run --profile    # Profile
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

## Statistics

| Metric | Value |
|--------|-------|
| Dart Files | 40+ |
| Pages | 13 |
| Widgets | 4 |
| Services | 2 |
| Tests | 67 ✅ |
| Platforms | Web, Android, iOS |

## Code Quality

✅ No errors/warnings • ✅ Null safe • ✅ 67/67 tests • ✅ Clean architecture

---

v0.1.0 | Complete and tested
