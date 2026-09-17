class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  bool isAdSdkInitialized = false;

  Future<void> init() async {
    // AdMob initialization placeholder abstraction
    isAdSdkInitialized = true;
  }

  Future<void> showBannerAd() async {
    // Banner ad renderer fallback
  }

  Future<bool> showRewardedAd({required Function() onRewarded}) async {
    // Graceful fallback for offline reward
    onRewarded();
    return true;
  }
}
