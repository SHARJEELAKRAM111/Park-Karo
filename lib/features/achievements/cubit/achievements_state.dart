import 'package:equatable/equatable.dart';

class AchievementsState extends Equatable {
  final List<String> claimedIds;
  final int completedLevelsCount;
  final int threeStarCount;
  final int totalCoins;
  final int hintsUsed;

  const AchievementsState({
    required this.claimedIds,
    required this.completedLevelsCount,
    required this.threeStarCount,
    required this.totalCoins,
    required this.hintsUsed,
  });

  @override
  List<Object?> get props => [claimedIds, completedLevelsCount, threeStarCount, totalCoins, hintsUsed];
}
