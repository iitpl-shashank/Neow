import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class DeStressViewModel with ChangeNotifier {
  VideoPlayerController? _controller;
  bool _isVideoActive = false;
  bool _isInitializing = false;
  bool _isInitialized = false;

  VideoPlayerController? get controller => _controller;
  bool get isVideoActive => _isVideoActive;
  bool get isInitializing => _isInitializing;
  bool get isInitialized => _isInitialized;

  bool get isBuffering =>
      _controller != null && _controller!.value.isBuffering;

  bool get isVideoLoading {
    if (!_isVideoActive) return false;
    if (_isInitializing || !_isInitialized || _controller == null) return true;
    // Once video is actively playing or has position, hide loader immediately!
    if (_controller!.value.isPlaying ||
        _controller!.value.position > Duration.zero) {
      return false;
    }
    return _controller!.value.isBuffering;
  }

  Future<File?> _getLocalCachedFile() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/de_stress_cached_video.mp4');
      if (await file.exists() && (await file.length()) > 1000000) {
        return file;
      }
    } catch (e) {
      log("Error checking local video cache: $e");
    }
    return null;
  }

  Future<void> initializeVideo(String url) async {
    if (_controller != null && _isInitialized) return;

    _isInitializing = true;
    notifyListeners();

    try {
      // 1. Check disk cache first for instant 0-latency playback
      final cachedFile = await _getLocalCachedFile();
      if (cachedFile != null) {
        log("Loading DeStress video from local disk cache: ${cachedFile.path}");
        _controller = VideoPlayerController.file(cachedFile);
        _controller!.addListener(_onControllerUpdate);
        await _controller!.initialize();
        _controller!.setLooping(true);
        _isInitialized = true;
        return;
      }

      // 2. Load from network URL
      log("Loading DeStress video from network URL: $url");
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _controller!.addListener(_onControllerUpdate);
      await _controller!.initialize();
      _controller!.setLooping(true);
      _isInitialized = true;

      // Cache video in background for future instant playback
      _cacheVideoToDiskInBackground(url);
    } catch (e) {
      log("Error initializing DeStress video with HTTPS: $e. Retrying HTTP fallback...");
      if (url.startsWith('https://')) {
        try {
          final httpUrl = url.replaceFirst('https://', 'http://');
          _controller?.removeListener(_onControllerUpdate);
          await _controller?.dispose();
          _controller = VideoPlayerController.networkUrl(Uri.parse(httpUrl));
          _controller!.addListener(_onControllerUpdate);
          await _controller!.initialize();
          _controller!.setLooping(true);
          _isInitialized = true;
          _cacheVideoToDiskInBackground(httpUrl);
        } catch (fallbackError) {
          log("Error initializing DeStress video fallback: $fallbackError");
        }
      }
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  Future<void> _cacheVideoToDiskInBackground(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/de_stress_cached_video.mp4');
      if (await file.exists() && (await file.length()) > 1000000) return;

      log("Starting background video disk caching...");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        log("Successfully cached DeStress video to disk! (${response.bodyBytes.length} bytes)");
      }
    } catch (e) {
      log("Background video caching error: $e");
    }
  }

  void _onControllerUpdate() {
    notifyListeners();
  }

  Future<void> startVideo(String url) async {
    _isVideoActive = true;
    notifyListeners();

    if (_controller == null || !_isInitialized) {
      await initializeVideo(url);
    }

    if (_controller != null && _isInitialized) {
      await _controller!.play();
    }
    notifyListeners();
  }

  Future<void> stopVideo() async {
    _isVideoActive = false;
    if (_controller != null && _isInitialized) {
      await _controller!.pause();
      await _controller!.seekTo(Duration.zero);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isVideoActive = false;
    super.dispose();
  }
}
