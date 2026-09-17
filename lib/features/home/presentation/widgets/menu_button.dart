import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final bool showArrow;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color = AppColors.cardBg,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 12),
            ],
          ],
        ),
      ),
    );
  }
}
