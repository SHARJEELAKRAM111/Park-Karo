import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final int stars;
  final double size;

  const StarRating({super.key, required this.stars, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isFilled = index < stars;
        return Icon(
          isFilled ? Icons.star : Icons.star_border,
          color: isFilled ? AppColors.goldStar : AppColors.lockGray,
          size: size,
        );
      }),
    );
  }
}
