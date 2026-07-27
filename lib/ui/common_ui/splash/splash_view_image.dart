import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../database/app_preferences.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import '../../naveli_ui/profile/your_naveli/your_naveli_view_model.dart';
import 'reel_scroll_view.dart';

class SplashViewImage extends StatefulWidget {
  const SplashViewImage({super.key});

  @override
  State<SplashViewImage> createState() => _SplashViewImageState();
}

class _SplashViewImageState extends State<SplashViewImage> {
  late SplashViewModel mViewModel;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isVideoFinished = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.checkIsFirstTime(
          mViewModel: Provider.of<YourNaveliViewModel>(context, listen: false));
    });

    if (AppPreferences.instance.getIsFirstTime()) {
      _initVideoPlayer();
    }
  }

  void _initVideoPlayer() {
    _videoController =
        VideoPlayerController.asset('assets/video/logoanimation.mp4');
    _videoController!.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController!.play();
        _videoController!.addListener(_videoListener);
      }
    }).catchError((error) {
      debugPrint("Error initializing video player: $error");
      _transitionToCarousel();
    });
  }

  void _videoListener() {
    if (_videoController == null) return;
    if (_videoController!.value.position >= _videoController!.value.duration) {
      _videoController!.removeListener(_videoListener);
      _transitionToCarousel();
    }
  }

  void _transitionToCarousel() {
    if (mounted && !_isVideoFinished) {
      setState(() {
        _isVideoFinished = true;
      });
      _videoController?.removeListener(_videoListener);
      _videoController?.dispose();
      _videoController = null;
    }
  }

  void _finishSplash() {
    AppPreferences.instance.setIsFirstTime(false);
    mViewModel.onFinishGIF();
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);

    if (AppPreferences.instance.getIsFirstTime()) {
      if (!_isVideoFinished) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              if (_isVideoInitialized && _videoController != null)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _transitionToCarousel,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      ),
                    ),
                  ),
                )
              else
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 20,
                child: GestureDetector(
                  onTap: _transitionToCarousel,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(128),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withAlpha(77),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return ReelScrollView(
          onFinish: _finishSplash,
          onSkip: _finishSplash,
        );
      }
    } else {
      return const WelComeGifView();
    }
  }
}
