import 'package:flutter_test/flutter_test.dart';
import 'package:campus_pulse/main.dart';

void main() {
  testWidgets('App boots to onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusPulseApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Stop guessing.'), findsOneWidget);
    expect(find.textContaining('hey SAM,'), findsNothing);
  });
}
