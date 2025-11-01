
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart';


void main() {
  testWidgets('Renders initial route', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // The first frame is often a loading screen, so we pump again
    await tester.pumpAndSettle(); 

    // Verify that the initial route is loaded. 
    // This is a basic check. We can add more specific assertions 
    // based on the content of your initial screen.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
