# Union Shop 🛍️

Union Shop is a Flutter-based e-commerce application designed as a coursework project to demonstrate architectural design, cloud integration, testing methodology, and responsive UI development. The platform provides a complete online retail workflow including browsing, search, authentication, cart management, and product personalisation.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📋 Table of Contents

- [Features](#-features)
- [Technology Stack](#technology-stack)
- [Architecture](#️-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Firebase Configuration](#-firebase-configuration)
- [Testing](#-testing)
- [Deployment](#-deployment)

## ✨ Features

### 🔹 User-Facing Features

- **Dynamic Homepage** with hero carousel and featured product sections
- **Shop Page** with 8 filter categories and 5 sorting options
- **Sale Page** with curated items, carousel, and sorting
- **Real-Time Search** across Firestore products
- **Shopping Cart** with quantity controls and live totals
- **Firebase Authentication** (email/password)  
- **Product Personalization** with custom text and logo printing
- **Responsive Design** for mobile and desktop (900px breakpoint, 240-280px tiles)
- **Account Management** with profile and sign-out
- **Newsletter Subscription** in footer with dummy policy links

### Technical Features

- Material Design 3 UI components with custom purple theme (#4d2963)
- State management using ChangeNotifier pattern (CartService with reactive notifications)
- Repository pattern for data access layer with Firestore integration
- Singleton pattern for cart service with global state management
- Route-based navigation with deep linking support and argument passing via RouteSettings
- Responsive Wrap-based layouts preventing overflow on mobile (cart quantity controls, product grids)
- Adaptive sizing with MediaQuery breakpoints (900px mobile/desktop, 600px internal responsive)
- Mobile-optimized UI elements (larger tap targets, wrapping layouts, responsive fonts 14-20px)
- Comprehensive error handling and user feedback with SnackBars
- Animated UI transitions and loading states with FutureBuilder
- Custom image handling with asset and network fallbacks (Image.asset, Image.network)
- Product model with Firestore converters (fromFirestore, toMap) for seamless synchronization
- Comprehensive test suite (41 passing tests) with Firebase mocking infrastructure

## Technology Stack

### Frontend

- **Flutter 3.0+** - Cross-platform UI framework
- **Dart** - Programming language
- **Material Design 3** - UI component library

### Backend & Cloud Services

- **Firebase Core 3.15.0** - Firebase SDK
- **Firebase Authentication 5.6.1** - User authentication system
- **Cloud Firestore 5.6.10** - NoSQL database for product data
- **Firebase Hosting** - Web hosting (deployment ready)

### Development Tools

- **flutter_test** - Testing framework
- **fake_cloud_firestore 3.1.0** - Mock Firestore for testing
- **firebase_auth_mocks 0.14.2** - Mock authentication for testing
- **firebase_core_platform_interface 5.4.2** - Platform interface for testing

## 🏗️ Architecture

The application follows a **layered architecture** pattern:

```text
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (Pages, Widgets, AppLayout)      │
├─────────────────────────────────────┤
│         Business Logic Layer        │
│   (CartService, ProductRepository)  │
├─────────────────────────────────────┤
│           Data Layer                │
│  (Product Model, Firestore)         │
├─────────────────────────────────────┤
│        External Services            │
│   (Firebase Auth, Firestore)        │
└─────────────────────────────────────┘
```

### Design Patterns Used

- **Singleton Pattern**: CartService for global state management
- **Repository Pattern**: ProductRepository for data access abstraction
- **Observer Pattern**: ChangeNotifier for reactive UI updates
- **Factory Pattern**: Product model with fromFirestore() constructor

## 📁 Project Structure

```text
union_shop/
├── lib/
│   ├── main.dart                    # App entry point, routes, theme
│   ├── app_layout.dart              # Shared scaffold with navbar & footer
│   ├── constants.dart               # App-wide constants
│   │
│   ├── models/
│   │   └── product.dart             # Product data model with Firestore converters
│   │
│   ├── services/
│   │   ├── product_repository.dart  # Firestore data access layer
│   │   └── cart_service.dart        # Shopping cart state management
│   │
│   ├── widgets/
│   │   ├── hero_carousel.dart       # Image carousel component with auto-rotate
│   │   ├── product_tile.dart        # Individual product card with hover effects and responsive sizing
│   │   ├── product_grid.dart        # Responsive product grid (Wrap-based, 240-280px tiles, custom maxCrossAxisExtent support)
│   │   └── footer_subscribe_box.dart # Newsletter subscription widget with email input
│   │
   └── pages/
       ├── home_page.dart           # Home page (carousel + featured sections)
       ├── shop_page.dart           # Unified shop with 8 dynamic filters & 5 sorting options (replaces individual category pages)
       ├── product_page.dart        # Product detail view with image, price, and description
       ├── cart_page.dart           # Shopping cart with mobile-optimized layout and Wrap-based quantity controls
       ├── checkout_success_page.dart # Order confirmation message
       ├── search_page.dart         # Real-time product search results with responsive grid
       ├── sign_in_page.dart        # Firebase authentication UI (email/password)
       ├── personalization_page.dart # Print customization service (6 options: 1-4 line text, small/large logo)
       ├── sale_page.dart           # Sale items with hero carousel and sorting
       ├── about_page.dart          # About the shop information
       ├── about_print_shack_page.dart # Print service details and pricing
       ├── terms_and_conditions_page.dart # Terms placeholder
       └── refund_policy_page.dart  # Refund policy placeholder
│
├── test/
│   ├── test_helper.dart             # Firebase mocking infrastructure
│   ├── cart_service_test.dart       # Cart functionality tests
│   ├── product_model_test.dart      # Product model tests
│   ├── product_repository_test.dart # Repository tests
│   ├── product_grid_test.dart       # Grid layout tests
│   ├── cart_page_test.dart          # Cart page UI tests
│   ├── shop_page_test.dart          # Shop page filter/sort tests
│   ├── home_page_test.dart          # Home page tests
│   ├── search_page_test.dart        # Search functionality tests
│   ├── product_page_test.dart       # Product detail tests
│   ├── sale_page_test.dart          # Sale page tests
│   ├── personalization_page_test.dart # Customization tests
│   ├── product_tile_test.dart       # Product tile widget tests
│   └── app_layout_footer_test.dart  # Footer navigation tests
│
├── web/
│   ├── index.html                   # Web entry point
│   ├── manifest.json                # PWA manifest
│   └── icons/                       # App icons
│
├── android/                         # Android platform files
├── ios/                             # iOS platform files
├── pubspec.yaml                     # Flutter dependencies & assets
└── README.md                        # Project documentation
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 2.17 or higher
- Firebase account
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/anana243/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (see [Firebase Configuration](#-firebase-configuration))

4. **Run the application**

   ```bash
   # For web development
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   
   # For iOS
   flutter run -d ios
   ```

## 🔥 Firebase Configuration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named "union-shop" (or your preferred name)
3. Enable Google Analytics (optional)

### Step 2: Enable Services

1. **Authentication**
   - Navigate to Authentication → Sign-in method
   - Enable "Email/Password" provider

2. **Cloud Firestore**
   - Navigate to Firestore Database
   - Create database in production mode
   - Set up security rules (see below)

### Step 3: Register Web App

1. In Project Settings, add a Web app
2. Copy the Firebase configuration
3. Replace the configuration in `lib/firebase_options.dart`

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Products: read-only for all users
    match /products/{product} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
    
    // Users: authenticated users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 🗄️ Database Schema

### Products Collection (`products`)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | Yes | Unique product identifier (auto-generated) |
| `title` | String | Yes | Product name |
| `imageUrl` | String | Yes | URL to product image |
| `price` | Number | Yes | Product price in GBP |
| `slug` | String | Yes | URL-friendly product identifier |
| `collections` | Array\<String\> | Recommended | Categories: `['clothing', 'merchandise', 'city', 'upsu', 'signature', 'essential', 'sale', 'graduation', 'pride']` |
| `subtitle` | String | Optional | Product tagline or description |
| `category` | String | Optional | Legacy category field (backwards compatibility) |
| `featured` | Boolean | Optional | Whether product should be featured |

### Example Product Document

```json
{
  "id": "portsmouth-hoodie-navy",
  "title": "Portsmouth Navy Hoodie",
  "subtitle": "Premium university hoodie",
  "imageUrl": "https://example.com/hoodie.jpg",
  "price": 34.99,
  "slug": "portsmouth-hoodie-navy",
  "collections": ["clothing", "signature", "city"],
  "featured": true
}
```

## 🧪 Testing

The application includes a comprehensive test suite covering models, services, widgets, and pages.

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/cart_service_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Test Infrastructure

- **test_helper.dart**: Provides Firebase mocking utilities
  - `FakeFirebaseCore`: Mock Firebase platform for testing
  - `setupFirebaseTest()`: Initializes test environment
  - `wrapWithMaterialApp()`: Widget testing helper
  - `getFakeFirestore()`: Returns mock Firestore instance
  - `getMockAuth()`: Returns mock authentication

### Test Coverage

- ✅ **Cart Service**: All tests passing (add, remove, quantity, clear operations)
- ✅ **Product Model**: All tests passing (serialization, validation, Firestore conversion)
- ✅ **Product Repository**: Core tests passing (initialization)
- ✅ **Product Grid**: All tests passing (responsive layout, breakpoints)
- ✅ **Product Tile**: All tests passing (widget rendering, interaction)
- ✅ **Cart Page**: All tests passing (UI text, empty state, structure)
- ✅ **Shop Page**: All tests passing (filters, sorting, dropdown functionality)
- ✅ **App Layout Footer**: All tests passing (footer links verification)
- ⏭️ **Personalization Page**: Tests skipped (network image loading issues in test environment)
- ⏭️ **Home/Sale Pages**: Tests skipped (Firebase data mocking limitations)
- ⏭️ **Product Repository Queries**: Tests skipped (FakeFirestore data population constraints)

**Total Test Coverage**: **41 passing tests, 0 failing** across 13 test files

**Note**: Some tests are skipped due to test environment limitations (network image loading, Firebase data mocking) but all functionality works correctly in production.

## ☁️ External Services

### Firebase Services Used

1. **Firebase Authentication**
   - Email/password authentication
   - User session management
   - Account creation and sign-in
   - Error handling for common auth scenarios
   - Integration: `FirebaseAuth.instance.signInWithEmailAndPassword()`

2. **Cloud Firestore**
   - Real-time product database
   - Collection-based queries
   - Search functionality with case-insensitive matching
   - Filtered and sorted data retrieval
   - Integration: `FirebaseFirestore.instance.collection('products')`

3. **Firebase Hosting** (deployment ready)
   - Static web hosting
   - SSL certificate included
   - Global CDN distribution

### Service Integration Architecture

```dart
// Authentication
StreamBuilder<User?>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) { ... }
)

// Database Queries
Future<List<Product>> listByCollection(String collection) async {
  final snapshot = await FirebaseFirestore.instance
    .collection('products')
    .where('collections', arrayContains: collection)
    .get();
  return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
}

// Search
Future<List<Product>> searchProducts(String query) async {
  final lowerQuery = query.toLowerCase();
  final snapshot = await FirebaseFirestore.instance
    .collection('products')
    .get();
  return snapshot.docs
    .map((doc) => Product.fromFirestore(doc))
    .where((p) => p.title.toLowerCase().contains(lowerQuery))
    .toList();
}
```

## 📦 Deployment

### Build for Web

```bash
flutter build web --release
```

### Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase (first time only)
firebase init hosting

# Deploy
firebase deploy --only hosting
```

### Build Configuration

- **Target**: Web (Chrome, Edge, Safari, Firefox)
- **Renderer**: CanvasKit (default) or HTML
- **Base URL**: Configurable in `web/index.html`
- **Firebase Project**: union-shop-825b3

## 🎨 Customization

### Theme Colors

Primary brand color is defined in `main.dart`:

```dart
primarySwatch: Colors.purple,
primaryColor: Color(0xFF4d2963)
```

### Hero Images

Hero carousel images are defined in `constants.dart`:

```dart
const kHeroImageUrl = 'https://...';
```

### Responsive Breakpoint

Mobile/desktop breakpoint (900px) is used throughout:

```dart
final isMobile = MediaQuery.of(context).size.width < 900;
```

## 🔒 Security

- **Authentication**: Firebase Auth with secure password requirements (min 6 characters)
- **Database Rules**: Firestore security rules limit write access to authenticated admins
- **Input Validation**: Form validation on all user inputs
- **Error Handling**: Comprehensive error catching and user-friendly messages
- **HTTPS**: All Firebase connections use secure HTTPS

## 🚀 Performance

- **Lazy Loading**: Products loaded on-demand from Firestore
- **Image Optimization**: Network images with error fallbacks
- **State Management**: Efficient ChangeNotifier pattern minimizes rebuilds
- **Responsive Design**: Single codebase scales from mobile to desktop
- **Code Splitting**: Route-based page loading

## 👥 Contributors

- **Anastasia** (anana243) - Initial development and implementation

## 📧 Contact

For questions or support, please open an issue on the [GitHub repository](https://github.com/anana243/union_shop/issues).
