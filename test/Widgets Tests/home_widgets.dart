import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/Screens/CharactersList.dart';
import 'package:rick_and_morty_app/Screens/Home.dart';
import 'package:flutter/material.dart';

//Testing if all listing options are available on home screen
void main() {
  testWidgets("Testing if \"All characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final allCharacters = find.text("See all characters");

    expect(allCharacters, findsOneWidget);
  });
  testWidgets("Testing if \"Male characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Male characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Female characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Female characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Genderless characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Genderless characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Characters with unknown gender\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Characters with unknown gender");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Human characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Human characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Alien characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Alien characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Robot characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Robot characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Alive characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Alive characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Dead characters\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Dead characters");
    expect(filter, findsOneWidget);
  });
  testWidgets("Testing if \"Characters with unknown status\" button is showing on screen", (widgetTester) async {
    await widgetTester.pumpWidget(const Home());

    final filter = find.text("Characters with unknown status");
    expect(filter, findsOneWidget);
  });
}
