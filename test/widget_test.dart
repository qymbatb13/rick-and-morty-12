import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('shows the character list screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Characters'), findsOneWidget);
  });
}
