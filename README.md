# Union Shop

A Flutter web app showcasing a shop front with a shared layout, responsive product sections, and placeholder product pages.

## Features

- Shared layout (AppBar + centered navigation + footer)
- Footer: Help & Information links with hover feedback and subscribe box
- Home page sections:
  - Essential Range
  - Signature Range
  - Portsmouth City Collection (2x2 grid on wide screens, centered)
- Hover/tap feedback on product tiles
- Product detail placeholder page via named routes
- Split, maintainable code structure

## Tech

- Flutter (web)
- Material UI components
- Responsive layout with Wrap/GridView and constraints

## Project Structure

- lib/
  - main.dart
  - app_layout.dart
  - product_page.dart
  - models/
    - product.dart
  - widgets/
    - product_tile.dart
    - hover_text.dart
    - footer_subscribe_box.dart
  - pages/
    - home_page.dart
    - shop_page.dart
    - print_shack_page.dart
    - sale_page.dart
    - about_page.dart
    - search_page.dart
    - terms_and_conditions_page.dart
    - refund_policy_page.dart

## Getting Started

1. Install Flutter:
   - Windows PowerShell:
     - winget install Flutter.Flutter
   - Or follow: <https://docs.flutter.dev/get-started/install>
2. Enable web:
   - flutter config --enable-web
3. Fetch dependencies:
   - flutter pub get
4. Run (Chrome):
   - flutter run -d chrome

## Navigation & Routing

- Named routes configured in main.dart
- Product tiles navigate to `/product` with route arguments:
  - title, price, imageUrl, slug

## Development Notes

- Avoid const for stateful widgets (HoverText, FooterSubscribeBox)
- Product images are slightly larger, constrained to prevent overflow
- Portsmouth City Collection grid is centered using ConstrainedBox
- Use Navigator.pushReplacementNamed for top navigation to keep the stack shallow

## Roadmap

- Implement real product data source
- Build full product detail UI (images carousel, variants, cart)
- Responsive hamburger menu for small screens
- Accessibility improvements (semantics, focus states)
- Unit/widget tests for tiles and pages

## License

Proprietary. Do not distribute without permission.
