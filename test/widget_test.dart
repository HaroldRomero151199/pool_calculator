// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:la_central_del_norte/core/app_constants.dart';
import 'package:la_central_del_norte/main.dart';
import 'package:la_central_del_norte/widgets/input_section.dart';

void main() {
  testWidgets('BilliardCostApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BilliardCostApp());

    // Verify that the app title is displayed.
    expect(find.text(AppConstants.appTitle), findsOneWidget);

    // Verify that the InputSection widget exists.
    expect(find.byType(InputSection), findsOneWidget);
  });
}
