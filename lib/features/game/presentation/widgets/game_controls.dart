import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onUndo;
  final VoidCallback onHint;
  final VoidCallback onReset;
  final bool canUndo;

  const GameControls({
    super.key,
    required this.onUndo,
    required this.onHint,
    required this.onReset,
    this.canUndo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _ControlButton(
              icon: Icons.undo_rounded,
              label: 'UNDO',
              onTap: canUndo ? onUndo : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ControlButton(
              icon: Icons.lightbulb_rounded,
              label: 'HINT',
              color: AppColors.accent,
              onTap: onHint,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ControlButton(
              icon: Icons.refresh_rounded,
              label: 'RESET',
              onTap: onReset,
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? Colors.white;
    final isDisabled = onTap == null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: isDisabled ? 0.35 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: activeColor.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: activeColor, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: activeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}