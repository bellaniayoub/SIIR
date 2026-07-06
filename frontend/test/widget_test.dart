import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('SIIR App initialization and Login Screen elements check', (WidgetTester tester) async {
    // Render the SIIR application widget tree
    await tester.pumpWidget(
      const ProviderScope(
        child: SIIRApp(),
      ),
    );

    // Validate that the brand title 'siir' is rendered
    expect(find.text('siir'), findsOneWidget);

    // Validate that the B2C Client and B2B Agency tabs are present
    expect(find.text('Client (B2C)'), findsOneWidget);
    expect(find.text('Agence (B2B)'), findsOneWidget);

    // Validate that the Google Sign-In button and Local Developer bypass button are present
    expect(find.text('Google Sign-In'), findsOneWidget);
    expect(find.text('Mock Local Developer Access'), findsOneWidget);
  });
}
