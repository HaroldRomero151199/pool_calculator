import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:billiard_time/core/app_constants.dart';
import 'package:billiard_time/main.dart';
import 'package:billiard_time/widgets/input_section.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('BilliardCostApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BilliardCostApp());
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appTitle), findsOneWidget);
    expect(find.byType(InputSection), findsOneWidget);
  });

  testWidgets('starts in dark mode when no preference is saved',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BilliardCostApp());
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
  });

  testWidgets('drawer switch changes from dark to white mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BilliardCostApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text("Modo oscuro"), findsOneWidget);
    expect(find.byKey(const Key('darkModeSwitch')), findsOneWidget);

    await tester.tap(find.byKey(const Key('darkModeSwitch')));
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final prefs = await SharedPreferences.getInstance();

    expect(materialApp.themeMode, ThemeMode.light);
    expect(prefs.getBool('isDarkMode'), isFalse);
  });
}
