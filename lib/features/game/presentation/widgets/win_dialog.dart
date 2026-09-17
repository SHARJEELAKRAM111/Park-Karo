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

  String get _ratingText {
    if (stars == 3) return 'PERFECT PARKING!';
    if (stars == 2) return 'GREAT DRIVING!';
    return 'LEVEL CLEARED!';
  }

  Color get _ratingColor {
    if (stars == 3) return AppColors.accent;
    if (stars == 2) return AppColors.primary;
    return AppColors.secondary;
  }

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
            constraints: const BoxConstraints(maxWidth: 360),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _ratingColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events_rounded,
                      size: 44,
                      color: _ratingColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _ratingText,
                    style: AppTypography.titleLarge.copyWith(
                      color: _ratingColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  StarRating(stars: stars, size: 36),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Text(
                      'Moves: $moves (Par: $par)',
                      style: AppTypography.bodyMedium.copyWith(color: Colors.white70),
                    ),
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
                        const Icon(Icons.monetization_on, color: AppColors.accent, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '+$coins Coins',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.accent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Replay Level',
                        onPressed: onReplay,
                        icon: const Icon(Icons.replay_rounded, color: Colors.white, size: 22),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.cardBgLight,
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onNextLevel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'NEXT LEVEL',
                              style: AppTypography.gameButton.copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Select Level',
                        onPressed: onLevelSelect,
                        icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 22),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.cardBgLight,
                          padding: const EdgeInsets.all(10),
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
