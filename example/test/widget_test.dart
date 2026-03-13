// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Example app renders platform detail screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('Flutter Demo Home Page'), findsOneWidget);

    // Let FutureBuilders settle and verify the page keeps expected sections.
    await tester.pump();
    await tester.pump();

    final infoTexts = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          ((widget.data?.contains('Device Info:') ?? false) ||
              (widget.data?.contains('Error getting device info:') ?? false) ||
              (widget.data?.contains('No data available') ?? false)),
    );

    final privateIpTexts = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          ((widget.data?.contains('Private IP:') ?? false) ||
              (widget.data?.contains('Error getting private IP:') ?? false) ||
              (widget.data?.contains('No private IP available') ?? false)),
    );

    final publicIpTexts = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          ((widget.data?.contains('Public IP:') ?? false) ||
              (widget.data?.contains('Error getting public IP:') ?? false) ||
              (widget.data?.contains('No public IP available') ?? false)),
    );

    expect(infoTexts, findsOneWidget);
    expect(privateIpTexts, findsOneWidget);
    expect(publicIpTexts, findsOneWidget);
  });
}
