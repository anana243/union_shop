# Union Shop

Flutter web storefront for the Students’ Union shop, with Firebase-backed products, filtering, cart, and personalization.

## Features

- Shared layout with responsive navigation and footer
- Home sections: Essential, Signature, Portsmouth City, Personalization promo
- Shop page: filter (All, Clothing, Merchandise, City, University, Signature, Essential) and sorting (A–Z, Z–A, Price)
- Dedicated pages: Clothing, Sale, City Collection, Print Shack About, About Us
- Product tiles with hover, price, and optional subtitle
- Product detail page with add-to-cart
- Personalization page (text/logo, quantity, cart) with a minimal notice

## Tech

- Flutter (Web)
- Firebase (Core/Auth if enabled) + Firestore for products
- Material 3 components

## Project Structure (high level)

- `lib/`
  - `main.dart` – routes / theme
  - `app_layout.dart` – shared scaffold
  - `constants.dart` – shared constants (hero image URL)
  - `models/`
    - `product.dart` – id, title, imageUrl, price, slug, subtitle
  - `services/`
    - `product_repository.dart` – Firestore queries (collections + legacy category)
    - `cart_service.dart`
  - `widgets/`
    - `hero_carousel.dart`
    - `product_tile.dart`
    - `product_grid.dart` – shared wrap/grid layout for tiles
    - `footer_subscribe_box.dart`, etc.
  - `pages/` – `home`, `shop`, `clothing`, `sale`, `portsmouth_city`, `print_shack_page`, `about_print_shack_page`, `about_page`, `personalization_page`, etc.

## Firestore Data

Collection: `products`

- Required: `title` (string), `imageUrl` (string), `price` (number), `slug` (string)
- Recommended: `collections` (array of strings) e.g. `['clothing']`, `['city']`, `['sale']`
- Optional: `subtitle` (string), `featured` (bool), legacy `category` (string)

Admin seeding

- Navigate to `/admin-seed` and use buttons to add demo products for Clothing/Signature/Essential, Merchandise (UPSU/Julia Gash), Sale, and City.

## Getting Started

- Install Flutter (Windows PowerShell):
  - `winget install Flutter.Flutter`
  - Or follow <https://docs.flutter.dev/get-started/install>
- Enable web: `flutter config --enable-web`
- Install deps: `flutter pub get`
- Firebase init: ensure `lib/firebase_options.dart` exists (already included)
- Run: `flutter run -d chrome`

## Notes

- Navigation uses `Navigator.pushNamed` to preserve back history.
- City product grid uses a 2-column layout; other pages use a responsive wrap.
- If older products don’t appear, add `collections: ['clothing' | 'merchandise' | 'city' | 'sale' | 'signature' | 'essential' | 'upsu']`.

## License

Proprietary. Do not distribute without permission.
