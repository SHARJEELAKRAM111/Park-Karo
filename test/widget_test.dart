import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:park_karo/core/storage/progress_repository.dart';
import 'package:park_karo/main.dart';

void main() {
  testWidgets('App loads cleanly', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = ProgressRepository(prefs);

    await tester.pumpWidget(
      RepositoryProvider<ProgressRepository>.value(
        value: repo,
        child: const ParkKaroApp(),
      ),
    );

    expect(find.byType(ParkKaroApp), findsOneWidget);
  });
}