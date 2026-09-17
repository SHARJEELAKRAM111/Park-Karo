import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/star_rating.dart';

class GameHeader extends StatelessWidget {
  final int levelId;
  final int moveCount;
  final int parMoves;
  final int coins;
  final String difficulty;
  final VoidCallback onBack;

  const GameHeader({
    super.key,
    required this.levelId,
    required this.moveCount,
    required this.parMoves,
    required this.coins,
    this.difficulty = 'Beginner',
    required this.onBack,
  });

  int get _liveStars {
    if (moveCount <= parMoves) return 3;
    if (moveCount <= parMoves + 3) return 2;
    return 1;
  }

  Color get _difficultyColor {
    switch (difficulty.toLowerCase()) {
      case 'grandmaster':
      case 'master':
        return const Color(0xFFD500F9); // Electric Violet
      case 'expert':
        return Colors.redAccent;
      case 'hard':
        return Colors.orangeAccent;
      case 'advanced':
      case 'medium':
        return Colors.amberAccent;
      default:
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.cardBg,
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('LEVEL $levelId', style: AppTypography.titleMedium.copyWith(fontSize: 16)),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _difficultyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _difficultyColor.withValues(alpha: 0.6)),
                        ),
                        child: Text(
                          difficulty.toUpperCase(),
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _difficultyColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StarRating(stars: _liveStars, size: 13),
                      const SizedBox(width: 6),
                      Text(
                        'Moves: $moveCount (Par: $parMoves)',
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.accent, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on, color: AppColors.accent, size: 16),
                const SizedBox(width: 4),
                Text('$coins', style: AppTypography.bodyLarge.copyWith(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
