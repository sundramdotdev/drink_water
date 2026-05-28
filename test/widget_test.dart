import 'package:flutter_test/flutter_test.dart';
import 'package:drink_water/main.dart';

void main() {
  testWidgets('Hydration tracker log test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DrinkWaterApp());

    // Verify that our progress starts at 0 ml.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('/ 2500 ml'), findsOneWidget);

    // Tap the '+250 ml' button and trigger a frame.
    await tester.tap(find.text('+250 ml'));
    await tester.pumpAndSettle();

    // Verify that our hydration progress has incremented.
    expect(find.text('250'), findsOneWidget);
  });
}
