import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

class _NoHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Prevent real network; Image.network will hit errorBuilder fast.
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

void setupTests() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = _NoHttpOverrides();
}
