import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logger/logger.dart';
import 'package:todo/main.dart' as test_app;

void main() async {
  Logger logger = Logger();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => logger.i('Next test is running...'));
  testWidgets('App launch test', (WidgetTester tester) async {
    await test_app.main();

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add).last);

    await tester.pumpAndSettle();

    String randomText = 'The first integration test in my life';

    await tester.enterText(
      find.byType(TextField),
      randomText,
    );

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.byType(TextButton).first);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 15));

    expect(find.text(randomText), findsWidgets);
  });
}
