import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../domain/achievement_model.dart';
import 'achievements_state.dart';

class AchievementsCubit extends Cubit<AchievementsState> {
  final ProgressRepository _repository;

  AchievementsCubit(this._repository)
      : super(AchievementsState(
          claimedIds: _repository.claimedAchievements,
          completedLevelsCount: _calculateCompletedLevels(_repository),
          threeStarCount: _calculateThreeStars(_repository),
          totalCoins: _repository.coins,
          hintsUsed: _repository.hintsUsed,
        ));

  static int _calculateCompletedLevels(ProgressRepository repo) {
    int count = 0;
    for (int i = 1; i <= 100; i++) {
      if (repo.getStars(i) > 0) count++;
    }
    return count;
  }

  static int _calculateThreeStars(ProgressRepository repo) {
    int count = 0;
    for (int i = 1; i <= 100; i++) {
      if (repo.getStars(i) == 3) count++;
    }
    return count;
  }

  void refresh() {
    emit(AchievementsState(
      claimedIds: _repository.claimedAchievements,
      completedLevelsCount: _calculateCompletedLevels(_repository),
      threeStarCount: _calculateThreeStars(_repository),
      totalCoins: _repository.coins,
      hintsUsed: _repository.hintsUsed,
    ));
  }

  Future<void> claimAchievement(Achievement achievement) async {
    if (state.claimedIds.contains(achievement.id)) return;
    await _repository.claimAchievement(achievement.id);
    await _repository.addCoins(achievement.rewardCoins);
    refresh();
  }
}
