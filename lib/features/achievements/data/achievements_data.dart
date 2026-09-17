import 'package:flutter/material.dart';
import '../domain/achievement_model.dart';

class AchievementsData {
  static const List<Achievement> allAchievements = [
    Achievement(
      id: 'first_park',
      title: 'First Park',
      description: 'Complete your first parking puzzle',
      rewardCoins: 100,
      icon: Icons.directions_car,
      targetValue: 1,
    ),
    Achievement(
      id: 'perfect_10',
      title: 'Perfect Parker',
      description: 'Get 3 stars on 10 levels',
      rewardCoins: 300,
      icon: Icons.star,
      targetValue: 10,
    ),
    Achievement(
      id: 'parking_pro',
      title: 'Parking Pro',
      description: 'Complete 50 levels',
      rewardCoins: 500,
      icon: Icons.verified,
      targetValue: 50,
    ),
    Achievement(
      id: 'master_parker',
      title: 'Master Parker',
      description: 'Complete all 100 levels',
      rewardCoins: 1000,
      icon: Icons.emoji_events,
      targetValue: 100,
    ),
    Achievement(
      id: 'coin_collector',
      title: 'Coin Tycoon',
      description: 'Accumulate 1,000 coins',
      rewardCoins: 250,
      icon: Icons.monetization_on,
      targetValue: 1000,
    ),
    Achievement(
      id: 'hint_master',
      title: 'Smart Parker',
      description: 'Use 5 hints to solve tough levels',
      rewardCoins: 150,
      icon: Icons.lightbulb,
      targetValue: 5,
    ),
  ];
}
