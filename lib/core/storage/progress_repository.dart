import 'package:shared_preferences/shared_preferences.dart';

class ProgressRepository {
  static const String _keyHighestUnlocked = 'highest_unlocked_level';
  static const String _keyStarsPrefix = 'stars_level_';
  static const String _keyBestMovesPrefix = 'best_moves_level_';
  static const String _keyCoins = 'coins_total';
  static const String _keyEquippedSkin = 'equipped_vehicle_skin';
  static const String _keyEquippedTheme = 'equipped_board_theme';
  static const String _keyUnlockedSkins = 'unlocked_skins';
  static const String _keyUnlockedThemes = 'unlocked_themes';
  static const String _keySoundEnabled = 'setting_sound_enabled';
  static const String _keyMusicEnabled = 'setting_music_enabled';
  static const String _keyHapticsEnabled = 'setting_haptics_enabled';
  static const String _keyDailyLastClaimed = 'daily_reward_last_claimed';
  static const String _keyDailyStreak = 'daily_reward_streak';
  static const String _keyClaimedAchievements = 'claimed_achievements';
  static const String _keyTotalMoves = 'stat_total_moves';
  static const String _keyHintsUsed = 'stat_hints_used';

  final SharedPreferences _prefs;

  ProgressRepository(this._prefs);

  int get highestUnlockedLevel => _prefs.getInt(_keyHighestUnlocked) ?? 1;

  Future<void> setHighestUnlockedLevel(int level) async {
    if (level > highestUnlockedLevel) {
      await _prefs.setInt(_keyHighestUnlocked, level);
    }
  }

  int getStars(int levelId) => _prefs.getInt(_keyStarsPrefix + levelId.toString()) ?? 0;

  Future<void> saveLevelCompletion({
    required int levelId,
    required int stars,
    required int moves,
  }) async {
    final currentStars = getStars(levelId);
    if (stars > currentStars) {
      await _prefs.setInt(_keyStarsPrefix + levelId.toString(), stars);
    }
    final best = getBestMoves(levelId);
    if (best == 0 || moves < best) {
      await _prefs.setInt(_keyBestMovesPrefix + levelId.toString(), moves);
    }
    await incrementTotalMoves(moves);
    await setHighestUnlockedLevel(levelId + 1);
  }

  int getBestMoves(int levelId) => _prefs.getInt(_keyBestMovesPrefix + levelId.toString()) ?? 0;

  int get coins => _prefs.getInt(_keyCoins) ?? 200;

  Future<void> addCoins(int amount) async {
    await _prefs.setInt(_keyCoins, coins + amount);
  }

  Future<bool> spendCoins(int amount) async {
    if (coins >= amount) {
      await _prefs.setInt(_keyCoins, coins - amount);
      return true;
    }
    return false;
  }

  String get equippedSkin => _prefs.getString(_keyEquippedSkin) ?? 'red_sports';
  Future<void> setEquippedSkin(String skinId) async => _prefs.setString(_keyEquippedSkin, skinId);

  List<String> get unlockedSkins =>
      _prefs.getStringList(_keyUnlockedSkins) ?? ['red_sports'];
  Future<void> unlockSkin(String skinId) async {
    final current = unlockedSkins;
    if (!current.contains(skinId)) {
      current.add(skinId);
      await _prefs.setStringList(_keyUnlockedSkins, current);
    }
  }

  String get equippedTheme => _prefs.getString(_keyEquippedTheme) ?? 'city_asphalt';
  Future<void> setEquippedTheme(String themeId) async => _prefs.setString(_keyEquippedTheme, themeId);

  List<String> get unlockedThemes =>
      _prefs.getStringList(_keyUnlockedThemes) ?? ['city_asphalt'];
  Future<void> unlockTheme(String themeId) async {
    final current = unlockedThemes;
    if (!current.contains(themeId)) {
      current.add(themeId);
      await _prefs.setStringList(_keyUnlockedThemes, current);
    }
  }

  bool get soundEnabled => _prefs.getBool(_keySoundEnabled) ?? true;
  Future<void> setSoundEnabled(bool val) async => _prefs.setBool(_keySoundEnabled, val);

  bool get musicEnabled => _prefs.getBool(_keyMusicEnabled) ?? true;
  Future<void> setMusicEnabled(bool val) async => _prefs.setBool(_keyMusicEnabled, val);

  bool get hapticsEnabled => _prefs.getBool(_keyHapticsEnabled) ?? true;
  Future<void> setHapticsEnabled(bool val) async => _prefs.setBool(_keyHapticsEnabled, val);

  String? get dailyLastClaimed => _prefs.getString(_keyDailyLastClaimed);
  Future<void> setDailyLastClaimed(String dateStr) async =>
      _prefs.setString(_keyDailyLastClaimed, dateStr);

  int get dailyStreak => _prefs.getInt(_keyDailyStreak) ?? 0;
  Future<void> setDailyStreak(int streak) async => _prefs.setInt(_keyDailyStreak, streak);

  List<String> get claimedAchievements =>
      _prefs.getStringList(_keyClaimedAchievements) ?? [];

  Future<void> claimAchievement(String id) async {
    final list = claimedAchievements;
    if (!list.contains(id)) {
      list.add(id);
      await _prefs.setStringList(_keyClaimedAchievements, list);
    }
  }

  int get totalMoves => _prefs.getInt(_keyTotalMoves) ?? 0;
  Future<void> incrementTotalMoves(int count) async =>
      _prefs.setInt(_keyTotalMoves, totalMoves + count);

  int get hintsUsed => _prefs.getInt(_keyHintsUsed) ?? 0;
  Future<void> incrementHintsUsed() async =>
      _prefs.setInt(_keyHintsUsed, hintsUsed + 1);

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}