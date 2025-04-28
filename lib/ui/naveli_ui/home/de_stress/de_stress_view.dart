import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:video_player/video_player.dart';

class DeStressView extends StatefulWidget {
  const DeStressView({super.key});

  @override
  State<DeStressView> createState() => _DeStressViewState();
}

// class _DeStressViewState extends State<DeStressView> {
//   late VideoPlayerController _controller;
//   bool isLoading = true;
//   int loopCount = 0;
//   bool isFirstVideo = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadVideo();
//   }
//
//   void _loadVideo() async {
//     if (isFirstVideo) {
//       // Load and play the first video
//       _controller = VideoPlayerController.asset(LocalImages.deStressVideo)
//         ..initialize().then((_) {
//           setState(() {
//             _controller
//                 .setLooping(false); // Set looping to false for the first video
//             isLoading = false;
//             _controller.play();
//           });
//           _controller.addListener(_videoController);
//         });
//     } else {
//       // Load and play the second video
//       _controller =
//           VideoPlayerController.asset(LocalImages.deStressVideoWithOutSecond)
//             ..initialize().then((_) {
//               setState(() {
//                 _controller.setLooping(
//                     true); // Set looping to true for the second video
//                 isLoading = false;
//                 _controller.play();
//               });
//               _controller.addListener(_videoController);
//             });
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   void _videoController() async {
//     if (_controller.value.isCompleted) {
//       if (isFirstVideo) {
//         // If the first video has completed, switch to the second video
//         setState(() {
//           isFirstVideo = false;
//           loopCount = 0; // Reset loop count for the second video
//         });
//         _loadVideo();
//       } else {
//         // If the second video has completed, check loop count
//         if (loopCount < 4) {
//           // Play the second video 5 times (loop count 0 to 4)
//           setState(() {
//             loopCount++;
//           });
//           _controller
//               .seekTo(Duration.zero); // Rewind the video to the beginning
//           _controller.play(); // Play the video again
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldBG(
//       child: Scaffold(
//         backgroundColor: CommonColors.mTransparent,
//         appBar: CommonAppBar(title: "De-Stress"),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: kCommonAllBottomPadding,
//           child: Row(
//             children: [
//               Expanded(
//                 child: PrimaryButton(
//                   onPress: () {
//                     _controller.pause();
//                   },
//                   label: "Pause",
//                 ),
//               ),
//               kCommonSpaceH15,
//               Expanded(
//                 child: PrimaryButton(
//                   onPress: () {
//                     _controller.play();
//                   },
//                   label: "Play",
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _DeStressViewState extends State<DeStressView> {
  late VideoPlayerController _controller;
  bool isLoading = true;
  int loopCount = 0;

  // late VideoPlayerModel vModel;

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: CommonColors.mTransparent,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "De-Stress",
                textAlign: TextAlign.center,
                style: getAppStyle(
                    color: CommonColors.mRed,
                    fontWeight: FontWeight.w500,
                    fontSize: 22),
              ),
              Text(
                "Are you sure want to Start ?",
                textAlign: TextAlign.center,
                style: getAppStyle(
                    color: CommonColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      buttonColor: CommonColors.mRed,
                      height: 40,
                      onPress: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(10),
                      label: "No",
                      labelColor: CommonColors.blackColor,
                      lblSize: 15,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: PrimaryButton(
                      buttonColor: CommonColors.greenColor,
                      height: 40,
                      onPress: () async {
                        Navigator.pop(context);
                        _controller.play();
                      },
                      borderRadius: BorderRadius.circular(10),
                      label: "Start",
                      lblSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () => showAlert(context));
    _controller = VideoPlayerController.asset(LocalImages.deStressVideo)
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(false);
          isLoading = false;
          // _controller.play();
        });
      });
    log("init loop :: $loopCount");
    // _controller.addListener(videoController);
  }

  Future<void> videoController() async {
    if (_controller.value.isCompleted) {
      log("messag");
      await _controller.seekTo(Duration.zero);
      await _controller.pause();
      // Video has ended
      if (!_controller.value.isPlaying && loopCount < 9) {
        log("messag $loopCount");
        // If loop count is less than 9, play the video again
        setState(() {
          loopCount++;
        });
        // _controller.seekTo(Duration.zero); // Start the video from the beginning
        _controller.play(); // Play the video
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: const CommonAppBar(title: ""),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: kDeviceWidth - 10,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: isLoading
                        ? VideoPlayer(
                            _controller,
                          )
                        : Image.asset(LocalImages.img_destress_img,
                            fit: BoxFit.contain),
                  ),
                ),
              ),
              Text(!isLoading ? "Destress yourself" : '',
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                  !isLoading
                      ? "Take a moment to relax\nwith 4-7-8 breathing"
                      : '',
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              kCommonSpaceV30,
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: kCommonAllBottomPadding,
          child: Row(
            children: [
              isLoading
                  ? Expanded(
                      child: PrimaryButton(
                        onPress: () {
                          setState(() {
                            isLoading = false;
                          });
                          _controller.pause();
                        },
                        label: "Stop",
                      ),
                    )
                  : Expanded(
                      child: PrimaryButton(
                        // width:120,
                        onPress: () {
                          setState(() {
                            isLoading = true;
                          });
                          _controller.play();
                        },
                        label: "Start",
                      ),
                    ),
              kCommonSpaceV30,
              kCommonSpaceV30,
              // kCommonSpaceH15,
            ],
          ),
        ),
      ),
    );
  }
}
