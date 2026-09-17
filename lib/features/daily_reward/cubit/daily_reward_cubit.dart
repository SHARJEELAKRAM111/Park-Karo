import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../domain/daily_reward_model.dart';
import 'daily_reward_state.dart';

class DailyRewardCubit extends Cubit<DailyRewardState> {
  final ProgressRepository _repository;

  DailyRewardCubit(this._repository)
      : super(DailyRewardState(
          streakDays: _repository.dailyStreak,
          canClaimToday: _checkCanClaim(_repository),
        ));

  static bool _checkCanClaim(ProgressRepository repo) {
    final lastStr = repo.dailyLastClaimed;
    if (lastStr == null) return true;
    final lastDate = DateTime.tryParse(lastStr);
    if (lastDate == null) return true;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
    return today.isAfter(lastDay);
  }

  Future<bool> claimTodayReward() async {
    if (!state.canClaimToday) return false;

    final newStreak = (state.streakDays % 7) + 1;
    final reward = DailyRewardDay.schedule[newStreak - 1];

    await _repository.addCoins(reward.coinReward);
    if (reward.specialReward != null) {
      await _repository.unlockSkin('neon_cyber');
    }

    final now = DateTime.now();
    final todayStr = DateTime(now.year, now.month, now.day).toIso8601String();

    await _repository.setDailyStreak(newStreak);
    await _repository.setDailyLastClaimed(todayStr);

    emit(DailyRewardState(
      streakDays: newStreak,
      canClaimToday: false,
    ));
    return true;
  }
}
