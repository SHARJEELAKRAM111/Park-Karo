import 'package:equatable/equatable.dart';

class DailyRewardState extends Equatable {
  final int streakDays;
  final bool canClaimToday;

  const DailyRewardState({
    required this.streakDays,
    required this.canClaimToday,
  });

  @override
  List<Object?> get props => [streakDays, canClaimToday];
}
