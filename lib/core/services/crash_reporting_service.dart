class CrashReportingService {
  static final CrashReportingService _instance = CrashReportingService._internal();
  factory CrashReportingService() => _instance;
  CrashReportingService._internal();

  void recordError(dynamic exception, StackTrace? stackTrace) {
    // Crash reporting logging fallback
  }
}
