import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();

  bool isSoundEnabled = true;
  bool isMusicEnabled = true;

  void init({bool sound = true, bool music = true}) {
    isSoundEnabled = sound;
    isMusicEnabled = music;
  }

  Future<void> playClick() async {
    if (!isSoundEnabled) return;
    try {
      // Audio playback handling with fallback/graceful catch
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/click.wav'));
    } catch (_) {}
  }

  Future<void> playMove() async {
    if (!isSoundEnabled) return;
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/move.wav'));
    } catch (_) {}
  }

  Future<void> playWin() async {
    if (!isSoundEnabled) return;
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/win.wav'));
    } catch (_) {}
  }

  Future<void> playInvalid() async {
    if (!isSoundEnabled) return;
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/invalid.wav'));
    } catch (_) {}
  }

  Future<void> playCoin() async {
    if (!isSoundEnabled) return;
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/coin.wav'));
    } catch (_) {}
  }

  void toggleSound(bool enabled) {
    isSoundEnabled = enabled;
  }

  void toggleMusic(bool enabled) {
    isMusicEnabled = enabled;
    if (!enabled) {
      _bgmPlayer.pause();
    }
  }
}
