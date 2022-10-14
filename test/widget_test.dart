// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_buzz/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    //Make sure POST button actually works:
    //elevated button:
    /*testWidgets('Add and remove a todo', (tester) async {
      // Enter text code...
      await tester.enterText(find.byType(TextField), 'hi');
      // Tap the add button.
      await tester.tap(find.byType(FloatingActionButton));

      // Rebuild the widget after the state has changed.
      await tester.pump();

      // Expect to find the item on screen.
      //have to change this when connected to the DB:
      expect(find.text('hi'), findsOneWidget);
    });*/

    //MANUAL TEST:
    //Create a post successfully through the UI (manual)
    //View all posts successfully through the UI (manual)
    //Like a post successfully through the UI (manual)
    //Remove a like from a post the user liked successfully through the UI (manual)
    //Test 404 page displays when following an invalid link (manual or automatic)
  });
}
