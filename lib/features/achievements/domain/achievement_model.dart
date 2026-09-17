import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final int rewardCoins;
  final IconData icon;
  final int targetValue;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.rewardCoins,
    required this.icon,
    required this.targetValue,
  });

  @override
  List<Object?> get props => [id, title, description, rewardCoins, icon, targetValue];
}
