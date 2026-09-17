import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/star_rating.dart';
import '../../../../shared/widgets/confetti_overlay.dart';

class WinDialog extends StatelessWidget {
  final int stars;
  final int moves;
  final int par;
  final int coins;
  final VoidCallback onReplay;
  final VoidCallback onNextLevel;
  final VoidCallback onLevelSelect;

  const WinDialog({
    super.key,
    required this.stars,
    required this.moves,
    required this.par,
    required this.coins,
    required this.onReplay,
    required this.onNextLevel,
    required this.onLevelSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const ConfettiOverlay(),
        Dialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      size: 48,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'LEVEL CLEARED!',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.secondary,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 12),
                  StarRating(stars: stars, size: 40),
                  const SizedBox(height: 14),
                  Text(
                    'Moves:  (Par: )',
                    style: AppTypography.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.monetization_on, color: AppColors.accent, size: 22),
                        const SizedBox(width: 6),
                        Text(
                          '+ Coins',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.accent,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: onReplay,
                        icon: const Icon(Icons.replay_rounded, color: Colors.white, size: 24),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.cardBgLight,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onNextLevel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text('NEXT LEVEL', style: AppTypography.gameButton),
                      ),
                      IconButton(
                        onPressed: onLevelSelect,
                        icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 24),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.cardBgLight,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
