import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/audio/audio_service.dart';
import '../../../../core/haptics/haptic_service.dart';
import '../../../../core/storage/progress_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ProgressRepository>();
    final audio = AudioService();
    final haptics = HapticService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTypography.titleMedium),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: const Text('Sound Effects'),
            value: repo.soundEnabled,
            onChanged: (val) {
              repo.setSoundEnabled(val);
              audio.toggleSound(val);
              setState(() {});
            },
          ),
          SwitchListTile(
            title: const Text('Music'),
            value: repo.musicEnabled,
            onChanged: (val) {
              repo.setMusicEnabled(val);
              audio.toggleMusic(val);
              setState(() {});
            },
          ),
          SwitchListTile(
            title: const Text('Haptic Feedback'),
            value: repo.hapticsEnabled,
            onChanged: (val) {
              repo.setHapticsEnabled(val);
              haptics.toggleHaptics(val);
              setState(() {});
            },
          ),
          const Divider(height: 32),
          ListTile(
            title: const Text('Reset All Progress', style: TextStyle(color: AppColors.error)),
            trailing: const Icon(Icons.delete_forever, color: AppColors.error),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogCtx) => AlertDialog(
                  title: const Text('Reset Progress?'),
                  content: const Text('Are you sure? All level unlocks, stars, and coins will be permanently cleared.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text('CANCEL')),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(dialogCtx);
                        await repo.clearAll();
                        if (mounted) setState(() {});
                      },
                      child: const Text('RESET', style: TextStyle(color: AppColors.error)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}