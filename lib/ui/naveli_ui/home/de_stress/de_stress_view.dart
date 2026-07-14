import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naveli_2023/services/api_url.dart';
import 'package:naveli_2023/ui/naveli_ui/home/de_stress/de_stress_info.dart';
import 'package:naveli_2023/ui/naveli_ui/home/de_stress/de_stress_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';

class DeStressView extends StatefulWidget {
  const DeStressView({super.key});

  @override
  State<DeStressView> createState() => _DeStressViewState();
}

class _DeStressViewState extends State<DeStressView>
    with WidgetsBindingObserver {
  // ---- Video player is owned HERE so disposal is 100% guaranteed ----
  VideoPlayerController? _videoController;
  bool _isInitializing = false;
  bool _isInitialized = false;
  bool _isError = false;

  late DeStressViewModel _vm;

  // ------------------------------------------------------------------ //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _vm = context.read<DeStressViewModel>();
        _vm.reset(); // always start in stopped state
      }
    });
  }

  // Pause video when app goes to background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _pauseAndReset();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Capture and null-out synchronously so nothing can call back into disposed state
    final ctrl = _videoController;
    _videoController = null;
    _isInitialized = false;
    _isInitializing = false;
    if (ctrl != null) {
      ctrl.removeListener(_onVideoListener);
      // pause() + dispose() as fire-and-forget — audio stops on first microtask
      ctrl.pause().then((_) => ctrl.dispose()).catchError((_) {});
    }
    _vm.reset();
    super.dispose();
  }

  // ------------------------------------------------------------------ //
  //  Controller management
  // ------------------------------------------------------------------ //

  Future<void> _initAndPlay() async {
    if (_isInitializing) return;

    setState(() {
      _isInitializing = true;
      _isError = false;
    });
    _vm.setInitializing(true);

    // Clean up any stale controller first
    await _releaseController();

    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(ApiUrl.DE_STRESS_VIDEO_URL),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false),
      );

      _videoController = controller;

      controller.addListener(_onVideoListener);
      await controller.initialize();

      if (!mounted) {
        // Widget was disposed while awaiting — clean up immediately
        controller.removeListener(_onVideoListener);
        await controller.dispose();
        _videoController = null;
        return;
      }

      await controller.setLooping(true);
      await controller.play();

      setState(() {
        _isInitialized = true;
        _isInitializing = false;
      });
      _vm
        ..setInitializing(false)
        ..setVideoActive(true);
    } catch (e) {
      log('[DeStress] Error initializing video: $e');
      await _releaseController();
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _isError = true;
        });
        _vm
          ..setInitializing(false)
          ..setVideoActive(false)
          ..setError(true);
      }
    }
  }

  Future<void> _stopVideo() async {
    await _pauseAndReset();
    _vm.setVideoActive(false);
  }

  /// Pause + seek to 0 without disposing the controller.
  Future<void> _pauseAndReset() async {
    if (_videoController != null && _isInitialized) {
      try {
        await _videoController!.pause();
        await _videoController!.seekTo(Duration.zero);
      } catch (e) {
        log('[DeStress] Error pausing: $e');
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// Fully releases the VideoPlayerController.
  Future<void> _releaseController() async {
    final ctrl = _videoController;
    _videoController = null;
    setState(() {
      _isInitialized = false;
      _isInitializing = false;
    });
    if (ctrl != null) {
      try {
        ctrl.removeListener(_onVideoListener);
        await ctrl.pause();
        await ctrl.dispose();
      } catch (e) {
        log('[DeStress] Error releasing controller: $e');
      }
    }
  }

  void _onVideoListener() {
    if (!mounted) return;
    final ctrl = _videoController;
    if (ctrl == null) return;
    if (ctrl.value.hasError) {
      log('[DeStress] Player error: ${ctrl.value.errorDescription}');
      _releaseController();
      _vm
        ..setVideoActive(false)
        ..setError(true);
    }
    setState(() {}); // refresh buffering indicator
  }

  // ------------------------------------------------------------------ //
  //  Helpers
  // ------------------------------------------------------------------ //

  bool get _isBuffering =>
      _isInitialized &&
      _videoController != null &&
      _videoController!.value.isBuffering;

  bool get _showLoadingOverlay =>
      _isInitializing || (_isInitialized && _isBuffering);

  // ------------------------------------------------------------------ //
  //  Build
  // ------------------------------------------------------------------ //

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // intercept back navigation: pause the video BEFORE the route pops
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          _videoController?.pause();
        }
      },
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: const CommonAppBar(title: ''),
          body: Consumer<DeStressViewModel>(
            builder: (context, vModel, _) {
              return Column(
                children: [
                  Expanded(
                    child: _buildVideoArea(vModel),
                  ),
                  if (!vModel.isVideoActive) _buildIdleContent(context),
                  if (!vModel.isVideoActive) kCommonSpaceV30,
                ],
              );
            },
          ),
          bottomNavigationBar: Consumer<DeStressViewModel>(
            builder: (context, vModel, _) {
              return Padding(
                padding: kCommonAllBottomPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: vModel.isVideoActive
                          ? PrimaryButton(
                              onPress: _stopVideo,
                              label: S.of(context)!.stop,
                            )
                          : PrimaryButton(
                              onPress: _initAndPlay,
                              label: S.of(context)!.start,
                            ),
                    ),
                    kCommonSpaceV30,
                    kCommonSpaceV30,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoArea(DeStressViewModel vModel) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder always visible underneath
          Image.asset(
            LocalImages.img_destress_img,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),

          // Video player (only when initialized and active)
          if (vModel.isVideoActive &&
              _isInitialized &&
              _videoController != null)
            Center(
              child: AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: VideoPlayer(_videoController!),
              ),
            ),

          // Loading / buffering overlay
          if (_showLoadingOverlay)
            Container(
              color: Colors.black.withValues(alpha: 0.35),
              child: const Center(
                child: CircularProgressIndicator(
                  color: CommonColors.primaryColor,
                ),
              ),
            ),

          // Error state
          if (_isError)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.white, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Could not load video.\nPlease check your connection.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() => _isError = false);
                        _vm.setError(false);
                        _initAndPlay();
                      },
                      child: const Text('Retry',
                          style: TextStyle(color: CommonColors.primaryColor)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIdleContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context)!.destressYourself,
              style: const TextStyle(
                color: CommonColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => push(const DeStressInfo()),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: CommonColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          S.of(context)!.takeAMomentToRelax,
          style: const TextStyle(
            color: CommonColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
