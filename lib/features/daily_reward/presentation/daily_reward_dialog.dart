import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../cubit/daily_reward_cubit.dart';
import '../cubit/daily_reward_state.dart';
import '../domain/daily_reward_model.dart';

class DailyRewardDialog extends StatelessWidget {
  const DailyRewardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyRewardCubit(context.read<ProgressRepository>()),
      child: Dialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: BlocBuilder<DailyRewardCubit, DailyRewardState>(
              builder: (context, state) {
                final cubit = context.read<DailyRewardCubit>();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('DAILY REWARD STREAK', style: AppTypography.titleMedium),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: DailyRewardDay.schedule.map((day) {
                        final isClaimed = day.day <= state.streakDays && !state.canClaimToday;
                        final isToday = day.day == (state.streakDays % 7) + 1 && state.canClaimToday;

                        return Container(
                          width: 68,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isToday ? AppColors.primary : AppColors.cardBgLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isClaimed
                                  ? AppColors.secondary
                                  : (isToday ? Colors.white : Colors.transparent),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text('Day ', style: const TextStyle(fontSize: 10, color: Colors.white70)),
                              const SizedBox(height: 2),
                              const Icon(Icons.monetization_on, color: AppColors.accent, size: 20),
                              const SizedBox(height: 2),
                              Text('+', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.canClaimToday
                          ? () async {
                              final navigator = Navigator.of(context);
                              final ok = await cubit.claimTodayReward();
                              if (ok) {
                                navigator.pop();
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        state.canClaimToday ? 'CLAIM TODAY' : 'ALREADY CLAIMED',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
