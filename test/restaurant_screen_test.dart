import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantapp/main.dart' as app;

void main() {
  group("Restaurant Screen Test", () {
    testWidgets("Testing if contains text recommendations", (WidgetTester tester) async {
      app.main();
      final object = find.text("Recommendation restaurant for you");
      await tester.pumpAndSettle();
      expect(object, findsOneWidget);
    });
  });
}
