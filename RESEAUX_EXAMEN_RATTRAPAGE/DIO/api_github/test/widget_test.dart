// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:api_github/main.dart';

void main() {
  testWidgets('Affiche le champ, le bouton et la liste', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Ajouter'), findsOneWidget);
    expect(find.text('Adam'), findsOneWidget);
    expect(find.text('Bilal'), findsOneWidget);
  });

  testWidgets('Ajoute un élément à la liste', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'Fatima');
    await tester.tap(find.text('Ajouter'));
    await tester.pump();

    expect(find.text('Fatima'), findsOneWidget);
  });
}
