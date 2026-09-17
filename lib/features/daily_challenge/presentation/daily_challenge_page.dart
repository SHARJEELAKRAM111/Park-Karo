import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../game/presentation/game_page.dart';
import '../../levels/data/level_repository.dart';

class DailyChallengePage extends StatelessWidget {
  const DailyChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daySeed = (now.year * 1000) + (now.month * 50) + now.day;
    final levelId = (daySeed % 100) + 1;
    final level = LevelRepository().getLevelById(levelId) ?? LevelRepository().getAllLevels().first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Challenge', style: AppTypography.titleMedium),
        backgroundColor: AppColors.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.today, size: 80, color: AppColors.accent),
            const SizedBox(height: 16),
            Text('TODAYS PUZZLE', style: AppTypography.titleLarge),
            const SizedBox(height: 8),
            Text('Date: ${now.day}/${now.month}/${now.year}', style: AppTypography.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GamePage(level: level),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('START DAILY PUZZLE'),
            ),
          ],
        ),
      ),
    );
  }
}
