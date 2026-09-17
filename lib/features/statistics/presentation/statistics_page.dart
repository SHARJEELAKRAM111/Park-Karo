import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ProgressRepository>();

    int completedCount = 0;
    int threeStarCount = 0;
    for (int i = 1; i <= 100; i++) {
      final s = repo.getStars(i);
      if (s > 0) completedCount++;
      if (s == 3) threeStarCount++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: AppTypography.titleMedium),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _StatTile(label: 'Levels Completed', value: '$completedCount / 100'),
          _StatTile(label: 'Three Star Levels', value: '$threeStarCount'),
          _StatTile(label: 'Total Moves Made', value: '${repo.totalMoves}'),
          _StatTile(label: 'Total Coins Balance', value: '${repo.coins}'),
          _StatTile(label: 'Hints Used', value: '${repo.hintsUsed}'),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70)),
        trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.accent)),
      ),
    );
  }
}
