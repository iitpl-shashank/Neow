import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class GearSoundService {
  static final GearSoundService _instance = GearSoundService._internal();
  factory GearSoundService() => _instance;
  GearSoundService._internal();

  AudioPlayer? _player;
  bool _isInitialized = false;
  int _lastPlayTime = 0;

  Future<void> init() async {
    if (_isInitialized && _player != null) return;
    try {
      _player = AudioPlayer();
      await _player!.setAsset('assets/audio/gear_tick.wav');
      await _player!.setVolume(1.0);
      _isInitialized = true;
    } catch (_) {
      _isInitialized = false;
    }
  }

  void triggerGearFeedback() {
    // 1. Trigger iOS wheel scroll vibration
    HapticFeedback.selectionClick();

    // 2. Play gear tick mechanical sound feedback with throttle for rapid spinning
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastPlayTime < 30) return;
    _lastPlayTime = now;

    if (_isInitialized && _player != null) {
      try {
        _player!.seek(Duration.zero);
        _player!.play();
      } catch (_) {
        SystemSound.play(SystemSoundType.click);
      }
    } else {
      SystemSound.play(SystemSoundType.click);
      init();
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
    _isInitialized = false;
  }
}
