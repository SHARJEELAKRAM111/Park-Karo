import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/star_rating.dart';
import '../../../game/domain/level_definition.dart';

class LevelCard extends StatelessWidget {
  final LevelDefinition level;
  final bool isUnlocked;
  final int stars;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.isUnlocked,
    required this.stars,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isUnlocked ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isUnlocked ? AppColors.cardBg : AppColors.cardBg.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked ? AppColors.primary.withValues(alpha: 0.4) : AppColors.lockGray,
            width: isUnlocked ? 1.5 : 1.0,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isUnlocked) ...[
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    level.id.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: StarRating(stars: stars, size: 14),
              ),
            ] else ...[
              const Icon(Icons.lock_rounded, color: AppColors.lockGray, size: 24),
              const SizedBox(height: 2),
              Text(
                level.id.toString(),
                style: const TextStyle(color: AppColors.lockGray, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}