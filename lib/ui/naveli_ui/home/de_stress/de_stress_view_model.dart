import 'package:flutter/material.dart';

/// Lightweight ViewModel — only holds UI-state flags.
/// The actual VideoPlayerController lifecycle is owned by the StatefulWidget,
/// NOT here, so disposal is guaranteed when the route is popped.
class DeStressViewModel with ChangeNotifier {
  bool _isVideoActive = false;
  bool _isInitializing = false;
  bool _isError = false;

  bool get isVideoActive => _isVideoActive;
  bool get isInitializing => _isInitializing;
  bool get isError => _isError;

  void setVideoActive(bool value) {
    if (_isVideoActive == value) return;
    _isVideoActive = value;
    notifyListeners();
  }

  void setInitializing(bool value) {
    if (_isInitializing == value) return;
    _isInitializing = value;
    notifyListeners();
  }

  void setError(bool value) {
    if (_isError == value) return;
    _isError = value;
    notifyListeners();
  }

  /// Resets all UI state — called when screen is entered or exited.
  void reset() {
    _isVideoActive = false;
    _isInitializing = false;
    _isError = false;
    notifyListeners();
  }
}
