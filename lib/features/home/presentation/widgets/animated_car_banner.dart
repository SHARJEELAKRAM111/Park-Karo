import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AnimatedCarBanner extends StatefulWidget {
  const AnimatedCarBanner({super.key});

  @override
  State<AnimatedCarBanner> createState() => _AnimatedCarBannerState();
}

class _AnimatedCarBannerState extends State<AnimatedCarBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = (_controller.value * 12) - 6;
        return Transform.translate(
          offset: Offset(0, offset),
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 30,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.cardBg,
                  child: const Icon(
                    Icons.directions_car,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
