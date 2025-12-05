import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/sign_in_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('SignInPage', () {
    testWidgets('renders with input fields and button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const SignInPage()));

      // Verify sign-in UI elements are present
      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('accepts email input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const SignInPage()));

      final textFields = find.byType(TextField);
      await tester.tap(textFields.first);
      await tester.enterText(textFields.first, 'test@example.com');
      
      expect(find.text('test@example.com'), findsWidgets);
    });
  });
}
