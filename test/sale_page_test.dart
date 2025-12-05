import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupFirebaseTest();
  });

  group('SalePage', () {
    testWidgets('renders with content', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp(const SalePage()));
      await waitForAsync(tester);

      expect(find.byType(SalePage), findsOneWidget);
    });
  });
}
