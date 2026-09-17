import 'package:equatable/equatable.dart';

class DailyRewardDay extends Equatable {
  final int day;
  final int coinReward;
  final String? specialReward;

  const DailyRewardDay({
    required this.day,
    required this.coinReward,
    this.specialReward,
  });

  static const List<DailyRewardDay> schedule = [
    DailyRewardDay(day: 1, coinReward: 100),
    DailyRewardDay(day: 2, coinReward: 150),
    DailyRewardDay(day: 3, coinReward: 200),
    DailyRewardDay(day: 4, coinReward: 250),
    DailyRewardDay(day: 5, coinReward: 300),
    DailyRewardDay(day: 6, coinReward: 400),
    DailyRewardDay(day: 7, coinReward: 500, specialReward: 'Cyber Skin Unlocked!'),
  ];

  @override
  List<Object?> get props => [day, coinReward, specialReward];
}
