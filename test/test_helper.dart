// ignore_for_file: unnecessary_import

import 'dart:io';
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

Widget wrapWithMaterialApp(Widget child) {
  return MaterialApp(
    home: child,
  );
}

FakeFirebaseFirestore getFakeFirestore() {
  return FakeFirebaseFirestore();
}

MockFirebaseAuth getMockAuth() {
  return MockFirebaseAuth();
}
