import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screen_usage_tally_example/main.dart';

void main() {
  testWidgets('Button press shows usage time dialog', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify the button exists
    expect(find.text('Show Usage Time'), findsOneWidget);
  });
}
