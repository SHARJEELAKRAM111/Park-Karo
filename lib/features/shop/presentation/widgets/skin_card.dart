import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/vehicle_skin.dart';

class SkinCard extends StatelessWidget {
  final VehicleSkin skin;
  final bool isUnlocked;
  final bool isEquipped;
  final VoidCallback onTap;

  const SkinCard({
    super.key,
    required this.skin,
    required this.isUnlocked,
    required this.isEquipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isEquipped ? AppColors.accent : Colors.white10,
          width: isEquipped ? 2.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: skin.primaryColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(skin.icon, color: skin.primaryColor, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skin.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(skin.description, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEquipped
                  ? AppColors.secondary
                  : (isUnlocked ? AppColors.primary : AppColors.accent),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              isEquipped ? 'EQUIPPED' : (isUnlocked ? 'EQUIP' : ' C'),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
