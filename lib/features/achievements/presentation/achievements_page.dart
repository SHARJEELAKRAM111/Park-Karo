import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/achievements_cubit.dart';
import '../cubit/achievements_state.dart';
import '../data/achievements_data.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementsCubit(context.read<ProgressRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Achievements', style: AppTypography.titleMedium),
          backgroundColor: AppColors.background,
        ),
        body: BlocBuilder<AchievementsCubit, AchievementsState>(
          builder: (context, state) {
            final cubit = context.read<AchievementsCubit>();

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: AchievementsData.allAchievements.length,
              itemBuilder: (context, index) {
                final ach = AchievementsData.allAchievements[index];
                final isClaimed = state.claimedIds.contains(ach.id);

                int progressVal = 0;
                if (ach.id == 'first_park' || ach.id == 'parking_pro' || ach.id == 'master_parker') {
                  progressVal = state.completedLevelsCount;
                } else if (ach.id == 'perfect_10') {
                  progressVal = state.threeStarCount;
                } else if (ach.id == 'coin_collector') {
                  progressVal = state.totalCoins;
                } else if (ach.id == 'hint_master') {
                  progressVal = state.hintsUsed;
                }

                final isUnlocked = progressVal >= ach.targetValue;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isUnlocked ? AppColors.accent : AppColors.cardBgLight,
                      child: Icon(ach.icon, color: isUnlocked ? Colors.black : Colors.white54),
                    ),
                    title: Text(ach.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${ach.description} ($progressVal/${ach.targetValue})'),
                    trailing: isClaimed
                        ? const Icon(Icons.check_circle, color: AppColors.secondary)
                        : ElevatedButton(
                            onPressed: isUnlocked ? () => cubit.claimAchievement(ach) : null,
                            child: Text('+${ach.rewardCoins} C'),
                          ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
