import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../database/app_preferences.dart';
import '../../../utils/local_images.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';

class SplashViewVdo extends StatefulWidget {
  const SplashViewVdo({super.key});

  @override
  State<SplashViewVdo> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashViewVdo> {
  late SplashViewModel mViewModel;
  late GifController firstController;
  late GifController secondController;
  late AudioPlayer player1;
  late AudioPlayer player2;
  late VideoPlayerController vdo_Controller;
  bool isPlayingFirstGif = true;
  bool isMute = true;
  bool isPlayingStart = false;

  loadVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    vdo_Controller.initialize().then((value) {
      if (mounted) {
        vdo_Controller.play();
        vdo_Controller.setLooping(true);
        setState(() {});
      }
    });
  }

  loadSecondVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    vdo_Controller.initialize().then((value) {
      if (mounted) {
        vdo_Controller.play();
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadVideoPlayer('assets/video/door_animation_starting.mp4');
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
    setState(() {
      isPlayingStart = true;
    });
    print(
        "Play Audio =============================================================");
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
      if (mounted) {
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
      }
    });
  }

  void toggleMute() {
    setState(() {
      isMute = !isMute;
    });
  }

  skipVideo() {



    if (mounted) {
      loadSecondVideoPlayer('assets/video/logoanimation.mp4');
      if (AppPreferences.instance.getIsFirstTime()) {
        Future.delayed(const Duration(seconds: 7), () {
          if (mounted) {
            vdo_Controller.setLooping(false);
            vdo_Controller.pause();
            setState(() {});
            mViewModel.onFinishGIF();
            AppPreferences.instance.setIsFirstTime(false);
          }
        });
      }
    }

    // vdo_Controller.pause();
    // vdo_Controller.removeListener(() {
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
    // vdo_Controller.dispose();
    // player1.stop();
    // player2.stop();
    // player1.dispose();
    // player2.dispose();
    // if (mounted) {
    //   mViewModel.onFinishGIF(); // Move to next screen or animation
    // }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);
    return AppPreferences.instance.getIsFirstTime()
        ? Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (isPlayingStart) {
            print("False ==");
          } else {
            playAudio1();

            Future.delayed(const Duration(seconds: 1), () {
              loadSecondVideoPlayer('assets/video/new_Door_Open.mp4');

              Future.delayed(const Duration(seconds: 28), () {
                if (mounted) {
                  loadSecondVideoPlayer('assets/video/logoanimation.mp4');
                  if (AppPreferences.instance.getIsFirstTime()) {
                    Future.delayed(const Duration(seconds: 7), () {
                      if (mounted) {
                        vdo_Controller.setLooping(false);
                        vdo_Controller.pause();
                        setState(() {});
                        mViewModel.onFinishGIF();
                        AppPreferences.instance.setIsFirstTime(false);
                      }
                    });
                  }
                }
              });
            });
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // vdo_Controller.value.size.width,
          height: MediaQuery.of(context).size.height,
          child: VideoPlayer(vdo_Controller),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: isPlayingStart,
            child: SizedBox(
              height: 30.0,
              width: 30.0,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: skipVideo,
                  child: Icon(
                    Icons.skip_next,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: isPlayingStart,
              child: SizedBox(width: 10,)),
          SizedBox(
            height: 30.0,
            width: 30.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (isMute) {
                      vdo_Controller.setVolume(0.0);
                    } else {
                      vdo_Controller.setVolume(1.0);
                    }
                    toggleMute();
                  });
                },
                child: Icon(
                  isMute ? Icons.volume_up : Icons.volume_off,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : const WelComeGifView();
  }

  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    vdo_Controller.dispose();
    super.dispose();
  }
}
