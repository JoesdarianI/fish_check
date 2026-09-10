import 'package:fish_check/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the FishCheck sign-in form', (tester) async {
    await tester.pumpWidget(const FishCheckApp());

    expect(find.text('FishCheck'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('demo account can sign in', (tester) async {
    await tester.pumpWidget(const FishCheckApp());
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('FishCheck'), findsOneWidget);
    expect(find.text('Log catch'), findsOneWidget);
  });
}
