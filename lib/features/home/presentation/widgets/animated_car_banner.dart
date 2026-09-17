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
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.25),
                  blurRadius: 32,
                  spreadRadius: 6,
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 48,
                  spreadRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/app_icon.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
                child: const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
