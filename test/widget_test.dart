import 'package:flutter_test/flutter_test.dart';
import 'package:fithub_by_ifty/main.dart'; // Imports your FitHubApp

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame.
    // We use FitHubApp instead of MyApp because you renamed it.
    await tester.pumpWidget(const FitHubApp());

    // 2. Verify that the Login Page text appears.
    // We look for "FitHub by Ifty" instead of "0" because that's on your login screen.
    expect(find.text('FitHub by Ifty'), findsOneWidget);

    // 3. Verify that we have a login button
    expect(find.text('Login'), findsOneWidget);
  });
}
