import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:billiard_time/core/app_constants.dart';
import 'package:billiard_time/main.dart';
import 'package:billiard_time/widgets/input_section.dart';

const String _testVersionLabel = 'Versión 9.8.7';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('BilliardCostApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const BilliardCostApp(
        initialIsDarkMode: true,
        appVersionLabel: _testVersionLabel,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appTitle), findsOneWidget);
    expect(find.byType(InputSection), findsOneWidget);
  });

  testWidgets('starts in dark mode when no preference is saved',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const BilliardCostApp(
        initialIsDarkMode: true,
        appVersionLabel: _testVersionLabel,
      ),
    );
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('can start in white mode before first frame',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const BilliardCostApp(
        initialIsDarkMode: false,
        appVersionLabel: _testVersionLabel,
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.light);
  });

  testWidgets('drawer switch changes from dark to white mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const BilliardCostApp(
        initialIsDarkMode: true,
        appVersionLabel: _testVersionLabel,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.darkModeLabel), findsOneWidget);
    expect(find.text(_testVersionLabel), findsOneWidget);
    expect(find.byKey(const Key('darkModeSwitch')), findsOneWidget);

    await tester.tap(find.byKey(const Key('darkModeSwitch')));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final prefs = await SharedPreferences.getInstance();

    expect(materialApp.themeMode, ThemeMode.light);
    expect(prefs.getBool('isDarkMode'), isFalse);
  });

  test('formats version label without build number', () {
    expect(
      AppConstants.formatVersionLabel(version: '1.2.3'),
      'Versión 1.2.3',
    );
  });
}
