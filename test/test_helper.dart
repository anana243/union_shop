import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class _NoHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Prevent real network; Image.network will hit errorBuilder fast.
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

typedef PlatformOptions = Map<String, dynamic>;

class FakeFirebaseCore extends FirebasePlatform {
  FakeFirebaseCore() : super();

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return FakeFirebaseApp(name);
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return FakeFirebaseApp(name ?? defaultFirebaseAppName);
  }

  @override
  List<FirebaseAppPlatform> get apps =>
      [FakeFirebaseApp(defaultFirebaseAppName)];
}

class FakeFirebaseApp extends FirebaseAppPlatform {
  FakeFirebaseApp(String name)
      : super(
          name,
          const FirebaseOptions(
            apiKey: 'fake-api-key',
            appId: 'fake-app-id',
            messagingSenderId: 'fake-sender-id',
            projectId: 'fake-project-id',
          ),
        );

  @override
  Future<void> delete() async {}

  @override
  bool get isAutomaticDataCollectionEnabled => false;

  @override
  Future<void> setAutomaticDataCollectionEnabled(bool enabled) async {}

  @override
  Future<void> setAutomaticResourceManagementEnabled(bool enabled) async {}
}

void setupFirebaseTest() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = _NoHttpOverrides();

  // Register fake Firebase
  FirebasePlatform.instance = FakeFirebaseCore();
}

/// Populates fake Firestore with sample product data for testing.
/// 
/// Creates test data across multiple collections (clothing, merchandise,
/// featured, sale) to support various test scenarios.
void populateTestFirestoreData(FakeFirebaseFirestore firestore) {
  // Add sample collections with test data
  firestore.collection('clothing').doc('1').set({
    'title': 'Test T-Shirt',
    'imageUrl': 'https://example.com/tshirt.jpg',
    'price': 15.99,
    'slug': 'test-tshirt',
    'subtitle': 'Comfortable cotton tee',
  });

  firestore.collection('clothing').doc('2').set({
    'title': 'Test Hoodie',
    'imageUrl': 'https://example.com/hoodie.jpg',
    'price': 35.99,
    'slug': 'test-hoodie',
    'subtitle': 'Warm and cozy',
  });

  firestore.collection('merchandise').doc('1').set({
    'title': 'Test Mug',
    'imageUrl': 'https://example.com/mug.jpg',
    'price': 12.99,
    'slug': 'test-mug',
    'subtitle': 'Your daily companion',
  });

  firestore.collection('featured').doc('1').set({
    'title': 'Featured Product',
    'imageUrl': 'https://example.com/featured.jpg',
    'price': 25.99,
    'slug': 'featured-product',
    'subtitle': 'Our top pick',
  });

  firestore.collection('sale').doc('1').set({
    'title': 'Sale Item 1',
    'imageUrl': 'https://example.com/sale1.jpg',
    'price': 9.99,
    'slug': 'sale-item-1',
    'subtitle': 'Great discount',
  });

  firestore.collection('sale').doc('2').set({
    'title': 'Sale Item 2',
    'imageUrl': 'https://example.com/sale2.jpg',
    'price': 14.99,
    'slug': 'sale-item-2',
    'subtitle': 'Limited time only',
  });
}

/// Wraps a widget with [MaterialApp] for testing.
/// 
/// Provides a minimal Material app context for widget tests.
Widget wrapWithMaterialApp(Widget child) {
  return MaterialApp(
    home: child,
  );
}

/// Gets a fake Firestore instance populated with test data.
FakeFirebaseFirestore getFakeFirestore() {
  final firestore = FakeFirebaseFirestore();
  populateTestFirestoreData(firestore);
  return firestore;
}

/// Gets a mock Firebase Auth instance for testing authentication flows.
MockFirebaseAuth getMockAuth() {
  return MockFirebaseAuth();
}

/// Creates a mock image provider for testing [Image.network] widgets.
/// 
/// Uses a 1x1 PNG in memory to avoid network calls during testing.
ImageProvider<Object> getMockImageProvider() {
  // Use MemoryImage to avoid network calls
  final Uint8List validPngBytes = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x02,
    0x00,
    0x00,
    0x00,
    0x90,
    0x77,
    0x53,
    0xDE,
    0x00,
    0x00,
    0x00,
    0x0C,
    0x49,
    0x44,
    0x41,
    0x54,
    0x08,
    0x99,
    0x63,
    0xF8,
    0xCF,
    0xC0,
    0x00,
    0x00,
    0x03,
    0x01,
    0x01,
    0x00,
    0x18,
    0xDD,
    0x8D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);
  return MemoryImage(validPngBytes);
}

/// Sets up standard desktop viewport for testing.
/// 
/// Common for pages with responsive layouts. Sets to 800x1200 at 1.0 DPR.
void setupDesktopViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1.0;
}

/// Resets the viewport after testing.
void resetViewport(WidgetTester tester) {
  addTearDown(() => tester.view.resetPhysicalSize());
  addTearDown(() => tester.view.resetDevicePixelRatio());
}

/// Sets up both desktop viewport and teardown in one call.
void setupDesktopViewportWithReset(WidgetTester tester) {
  setupDesktopViewport(tester);
  resetViewport(tester);
}

/// Waits for Firebase/async operations using multiple small pumps.
/// 
/// Avoids timeouts while allowing UI to settle. Pumps [iterations] times
/// with 50ms delays between each pump (default 20 iterations = 1 second).
Future<void> waitForAsync(WidgetTester tester, {int iterations = 20}) async {
  for (int i = 0; i < iterations; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

/// Creates a [MaterialApp] with a simple home widget.
/// 
/// Useful for quickly wrapping widgets in test context.
Widget createTestApp(Widget home) {
  return MaterialApp(
    home: home,
  );
}
