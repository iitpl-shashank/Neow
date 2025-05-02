library;

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../utils/local_images.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import 'splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashViewModel mViewModel;
  late GifController firstController;
  late GifController secondController;
  late AudioPlayer player1;
  late AudioPlayer player2;
  bool isPlayingFirstGif = true;

  @override
  void initState() {
    super.initState();
    firstController = GifController(
      autoPlay: true,
      loop: false,
    );
    secondController = GifController(
      autoPlay: false,
      loop: false,
      onFinish: onFinished, // Set onFinish callback for the second GIF
    );

    Future.delayed(Duration.zero, () {
      mViewModel.checkIsFirstTime();
    });

    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player1.setAsset(LocalImages.au_knock_door);
    player2.setAsset(LocalImages.knock_door_full_video);

  }

  void onFinished() {
    mViewModel.onFinishGIF();
  }

  Future<void> playAudio1() async {
    try {
      await player1.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playAudio2() async {
    try {
      await player2.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void toggleGif() {
    setState(() {
      playAudio1();
      playAudio2();
      isPlayingFirstGif = !isPlayingFirstGif;
      if (isPlayingFirstGif) {
        firstController.play();
        secondController.pause();
      } else {
        firstController.pause();
        secondController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);
    return AppPreferences.instance.getIsFirstTime()
        ? Scaffold(
            body: GestureDetector(
              onDoubleTap: () async {
                toggleGif();
                if (AppPreferences.instance.getIsFirstTime()) {
                  // condition TRUE --> set first time false after 1 second
                  Future.delayed(const Duration(seconds: 1), () {
                    // updating after 1 second because in Splash view we fetch with singleton instance
                    AppPreferences.instance.setIsFirstTime(false);
                  });
                }
              },
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: isPlayingFirstGif ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1),
                    child: GifView.asset(
                      LocalImages.gif_knock_door,
                      controller: firstController,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isPlayingFirstGif ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 1),
                    child: GifView.asset(
                      LocalImages.gif_opendoor,
                      controller: secondController,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          )
        : const WelComeGifView();
  }

  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    super.dispose();
  }
}
