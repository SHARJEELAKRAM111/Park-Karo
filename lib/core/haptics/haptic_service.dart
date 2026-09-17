import 'package:flutter/services.dart';

class HapticService {
  static final HapticService _instance = HapticService._internal();
  factory HapticService() => _instance;
  HapticService._internal();

  bool isHapticsEnabled = true;

  void init({bool enabled = true}) {
    isHapticsEnabled = enabled;
  }

  void lightImpact() {
    if (!isHapticsEnabled) return;
    HapticFeedback.lightImpact();
  }

  void mediumImpact() {
    if (!isHapticsEnabled) return;
    HapticFeedback.mediumImpact();
  }

  void heavyImpact() {
    if (!isHapticsEnabled) return;
    HapticFeedback.heavyImpact();
  }

  void selectionClick() {
    if (!isHapticsEnabled) return;
    HapticFeedback.selectionClick();
  }

  void successNotification() {
    if (!isHapticsEnabled) return;
    HapticFeedback.vibrate();
  }

  void toggleHaptics(bool enabled) {
    isHapticsEnabled = enabled;
  }
}
