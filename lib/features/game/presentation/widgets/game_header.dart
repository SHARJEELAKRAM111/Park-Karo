import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class GameHeader extends StatelessWidget {
  final int levelId;
  final int moveCount;
  final int parMoves;
  final int coins;
  final VoidCallback onBack;

  const GameHeader({
    super.key,
    required this.levelId,
    required this.moveCount,
    required this.parMoves,
    required this.coins,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.cardBg,
              padding: const EdgeInsets.all(10),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('LEVEL ', style: AppTypography.titleMedium),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Moves:  (Par: )',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.accent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on, color: AppColors.accent, size: 18),
                const SizedBox(width: 4),
                Text('', style: AppTypography.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
