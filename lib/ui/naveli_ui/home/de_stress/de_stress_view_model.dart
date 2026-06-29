import 'dart:developer';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naveli_2023/utils/local_images.dart';

class DeStressViewModel with ChangeNotifier {
  BetterPlayerController? _betterPlayerController;
  bool _isVideoActive = false;
  bool _isInitializing = false;
  bool _isInitialized = false;
  bool _isBuffering = false;

  BetterPlayerController? get betterPlayerController => _betterPlayerController;
  bool get isVideoActive => _isVideoActive;
  bool get isInitializing => _isInitializing;
  bool get isInitialized => _isInitialized;

  bool get isVideoLoading {
    if (!_isVideoActive) return false;
    if (_isInitializing || !_isInitialized || _betterPlayerController == null) {
      return true;
    }
    return _isBuffering;
  }

  Future<void> onScreenInit(String url) async {
    _isVideoActive = true;
    notifyListeners();

    if (_betterPlayerController == null || !_isInitialized) {
      await initializeVideo(url);
    } else {
      try {
        _betterPlayerController!.play();
      } catch (e) {
        log("Error playing video on screen init, reinitializing: $e");
        await initializeVideo(url);
        _betterPlayerController?.play();
      }
    }
    notifyListeners();
  }

  void onScreenDispose() {
    _isVideoActive = false;
    if (_betterPlayerController != null && _isInitialized) {
      try {
        _betterPlayerController!.pause();
        _betterPlayerController!.seekTo(Duration.zero);
      } catch (e) {
        log("Error pausing video on screen dispose: $e");
      }
    }
    notifyListeners();
  }

  Future<void> initializeVideo(String url) async {
    // If controller exists but was disposed or in bad state, clean up first
    if (_betterPlayerController != null) {
      try {
        _betterPlayerController!.removeEventsListener(_onPlayerEvent);
        _betterPlayerController!.dispose();
      } catch (e) {
        log("Error cleaning up existing controller: $e");
      }
      _betterPlayerController = null;
      _isInitialized = false;
    }

    _isInitializing = true;
    notifyListeners();

    try {
      final betterPlayerConfiguration = BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        fit: BoxFit.contain,
        expandToFill: false,
        autoDispose: false, // Managed by ViewModel lifecycle safely
        handleLifecycle: true,
        fullScreenByDefault: false,
        allowedScreenSleep: false,
        deviceOrientationsAfterFullScreen: const [
          DeviceOrientation.portraitUp,
        ],
        deviceOrientationsOnFullScreen: const [
          DeviceOrientation.portraitUp,
        ],
        placeholder: Image.asset(
          LocalImages.img_destress_img,
          fit: BoxFit.contain,
        ),
        showPlaceholderUntilPlay: true,
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      );

      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize: 50 * 1024 * 1024,
          maxCacheFileSize: 50 * 1024 * 1024,
          key: "de_stress_video_cache",
        ),
      );

      _betterPlayerController =
          BetterPlayerController(betterPlayerConfiguration);
      _betterPlayerController!.addEventsListener(_onPlayerEvent);
      await _betterPlayerController!.setupDataSource(dataSource);
      _isInitialized = true;
      if (_isVideoActive) {
        _betterPlayerController!.play();
      }
    } catch (e) {
      log("Error initializing BetterPlayer in DeStressViewModel: $e");
      if (url.startsWith('https://')) {
        try {
          final httpUrl = url.replaceFirst('https://', 'http://');
          final fallbackDataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            httpUrl,
            cacheConfiguration: const BetterPlayerCacheConfiguration(
              useCache: true,
              maxCacheSize: 50 * 1024 * 1024,
              maxCacheFileSize: 50 * 1024 * 1024,
              key: "de_stress_video_cache_http",
            ),
          );
          await _betterPlayerController?.setupDataSource(fallbackDataSource);
          _isInitialized = true;
          if (_isVideoActive) {
            _betterPlayerController?.play();
          }
        } catch (fallbackError) {
          log("Error initializing BetterPlayer fallback: $fallbackError");
        }
      }
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      _isInitialized = true;
      notifyListeners();
    } else if (event.betterPlayerEventType ==
        BetterPlayerEventType.bufferingStart) {
      _isBuffering = true;
      notifyListeners();
    } else if (event.betterPlayerEventType ==
            BetterPlayerEventType.bufferingEnd ||
        event.betterPlayerEventType == BetterPlayerEventType.play) {
      _isBuffering = false;
      notifyListeners();
    }
  }

  Future<void> startVideo(String url) async {
    _isVideoActive = true;
    notifyListeners();

    if (_betterPlayerController == null || !_isInitialized) {
      await initializeVideo(url);
    } else {
      try {
        _betterPlayerController!.play();
      } catch (e) {
        await initializeVideo(url);
        _betterPlayerController?.play();
      }
    }
    notifyListeners();
  }

  Future<void> stopVideo() async {
    _isVideoActive = false;
    if (_betterPlayerController != null && _isInitialized) {
      try {
        _betterPlayerController!.pause();
        _betterPlayerController!.seekTo(Duration.zero);
      } catch (e) {
        log("Error stopping video: $e");
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    if (_betterPlayerController != null) {
      try {
        _betterPlayerController!.removeEventsListener(_onPlayerEvent);
        _betterPlayerController!.dispose();
      } catch (e) {
        log("Error disposing BetterPlayerController: $e");
      }
      _betterPlayerController = null;
    }
    _isInitialized = false;
    _isVideoActive = false;
    super.dispose();
  }
}
