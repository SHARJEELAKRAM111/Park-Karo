import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/audio/audio_service.dart';
import 'core/haptics/haptic_service.dart';
import 'core/storage/progress_repository.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final progressRepository = ProgressRepository(prefs);

  AudioService().init(
    sound: progressRepository.soundEnabled,
    music: progressRepository.musicEnabled,
  );
  HapticService().init(
    enabled: progressRepository.hapticsEnabled,
  );

  runApp(
    RepositoryProvider<ProgressRepository>.value(
      value: progressRepository,
      child: const ParkKaroApp(),
    ),
  );
}

class ParkKaroApp extends StatelessWidget {
  const ParkKaroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Karo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
