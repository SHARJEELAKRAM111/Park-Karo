class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]) async {
    // Analytics logging abstraction
  }

  Future<void> logLevelCompleted(int levelId, int moves, int stars) async {
    await logEvent('level_completed', {
      'level_id': levelId,
      'moves': moves,
      'stars': stars,
    });
  }
}
