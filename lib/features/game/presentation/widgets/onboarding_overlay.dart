import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  const OnboardingOverlay({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withValues(alpha: 0.75),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.touch_app, color: AppColors.accent, size: 64),
              const SizedBox(height: 16),
              const Text(
                'HOW TO PLAY',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Select and drag vehicles along their track to clear a path and guide the target RED car to the exit!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onDismiss,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('GOT IT!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
