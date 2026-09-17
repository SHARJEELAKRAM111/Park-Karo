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
        final offset = (_controller.value * 20) - 10;
        return Transform.translate(
          offset: Offset(offset, 0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                )
              ],
            ),
            child: const Icon(
              Icons.directions_car,
              size: 100,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
