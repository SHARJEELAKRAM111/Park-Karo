import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:park_karo/core/storage/progress_repository.dart';
import 'package:park_karo/features/home/presentation/home_page.dart';
import 'package:park_karo/features/game/presentation/game_page.dart';
import 'package:park_karo/features/levels/data/level_repository.dart';
import 'package:park_karo/features/levels/presentation/level_select_page.dart';
import 'package:park_karo/features/shop/presentation/shop_page.dart';
import 'package:park_karo/features/statistics/presentation/statistics_page.dart';
import 'package:park_karo/features/daily_challenge/presentation/daily_challenge_page.dart';

void main() {
  final testSizes = [
    const Size(320, 568), // Small phone
    const Size(360, 640), // Medium phone
    const Size(390, 844), // Standard modern phone
    const Size(768, 1024), // Tablet
  ];

  late ProgressRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repo = ProgressRepository(prefs);
  });

  for (final size in testSizes) {
    testWidgets('No overflow on HomePage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: const MaterialApp(home: HomePage()),
        ),
      );
      // HomePage has a continuous car animation loop, so pump finite frames
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('No overflow on GamePage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final level = LevelRepository().getAllLevels().first;

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: MaterialApp(home: GamePage(level: level)),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(GamePage), findsOneWidget);
    });

    testWidgets('No overflow on LevelSelectPage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: const MaterialApp(home: LevelSelectPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LevelSelectPage), findsOneWidget);
    });

    testWidgets('No overflow on ShopPage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: const MaterialApp(home: ShopPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ShopPage), findsOneWidget);
    });

    testWidgets('No overflow on StatisticsPage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: const MaterialApp(home: StatisticsPage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(StatisticsPage), findsOneWidget);
    });

    testWidgets('No overflow on DailyChallengePage at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        RepositoryProvider<ProgressRepository>.value(
          value: repo,
          child: const MaterialApp(home: DailyChallengePage()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DailyChallengePage), findsOneWidget);
    });
  }
}
