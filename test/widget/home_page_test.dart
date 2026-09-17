import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:park_karo/core/storage/progress_repository.dart';
import 'package:park_karo/features/home/presentation/home_page.dart';

void main() {
  testWidgets('HomePage renders game title and play button', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = ProgressRepository(prefs);

    await tester.pumpWidget(
      RepositoryProvider<ProgressRepository>.value(
        value: repo,
        child: const MaterialApp(home: HomePage()),
      ),
    );

    expect(find.text('PARK KARO'), findsOneWidget);
    expect(find.text('PLAY LEVEL 1'), findsOneWidget);
  });
}
