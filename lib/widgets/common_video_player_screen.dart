

// class VideoPlayerScreen extends StatefulWidget {
//   final String link;
//   final VideoPlayerController? controller;
//   final bool? isFillAvailableSpace;
//   final bool? isButtonVisible;
//   final bool? isLoop;
//   final bool? isMute;
//
//   const VideoPlayerScreen({
//     required this.link,
//     this.controller,
//     this.isFillAvailableSpace = false,
//     this.isButtonVisible = false,
//     this.isLoop = false,
//     this.isMute = false,
//     super.key,
//   });
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   bool isLoading = true;
//   bool isPlaying = false;
//
//   // late VideoPlayerModel vModel;
//
//   @override
//   void initState() {
//     log("initState :: ${widget.link}");
//     super.initState();
//     _controller = widget.controller ??
//         VideoPlayerController.networkUrl(Uri.parse(widget.link))
//           ..initialize().then((_) {
//             setState(() {
//               if (widget.isMute!) _controller.setVolume(0);
//               _controller.setLooping(widget.isLoop!);
//               isLoading = false;
//               // _controller.play();
//             });
//           });
//     _controller.addListener(() {
//       setState(() {
//         isPlaying = _controller.value.isPlaying;
//       });
//     });
//   }
//
//   @override
//   void activate() {
//     _controller.play();
//     log("activate :: ${widget.link}");
//     super.activate();
//   }
//
//   @override
//   void deactivate() {
//     _controller.pause();
//     log("deactivate :: ${widget.link}");
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     log("dispose :: ${widget.link}");
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final playPushButton = IconButton(
//       color: Colors.white,
//       style: IconButton.styleFrom(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.black.withOpacity(0.5),
//       ),
//       onPressed: () {
//         setState(() {
//           if (_controller.value.isPlaying) {
//             _controller.pause();
//           } else {
//             _controller.play();
//           }
//         });
//       },
//       icon: Icon(
//         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//       ),
//     );
//
//     return Stack(
//       children: [
//         widget.isFillAvailableSpace!
//             ? VideoPlayer(_controller)
//             : AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         ),
//         if (isLoading)
//           const Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 2,
//             ),
//           ),
//         Align(
//           alignment: Alignment.center,
//           child: !isPlaying && widget.isButtonVisible!
//               ? playPushButton
//               : const SizedBox.shrink(),
//         ),
//       ],
//     );
//   }
// }
//
//
// class VideoPlayerModel with ChangeNotifier {
//   VideoPlayerController? _controller;
//   bool isLoading = false;
//
//   Future<void> initVideoPlayer(String link,
//       {bool isLoop = false, bool isMute = false}) async {
//     _controller = VideoPlayerController.networkUrl(Uri.parse(link));
//     await _controller!.initialize();
//     isLoading = false;
//     _controller!.setLooping(isLoop);
//     if (isMute) {
//       _controller!.setVolume(0);
//     }
//     _controller!.play();
//   }
// }


//********


// class VideoPlayerScreen extends StatefulWidget {
//   final String link;
//   final bool? isFillAvailableSpace;
//   final bool? isButtonVisible;
//   final bool? isLoop;
//   final bool? isMute;
//
//   const VideoPlayerScreen({
//     required this.link,
//     this.isFillAvailableSpace = false,
//     this.isButtonVisible = false,
//     this.isLoop = false,
//     this.isMute = false,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;
//   bool isLoading = true;
//   bool isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.link) ?? '',
//       flags: YoutubePlayerFlags(
//         autoPlay: false,
//         hideThumbnail: true,
//         showLiveFullscreenButton: false,
//         loop: false,
//         mute: widget.isMute!,
//       ),
//     )..addListener(() {
//         setState(() {
//           isPlaying = _controller.value.isPlaying;
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: double.infinity, // Set width to match parent
//           height: kDeviceHeight / 4,
//           child: YoutubePlayer(
//             controller: _controller,
//             bottomActions: [
//               Expanded(flex: 0, child: CurrentPosition()),
//               Expanded(
//                 flex: 1,
//                 child: ProgressBar(
//                 ),
//               ),
//               Expanded(flex: 0,child: RemainingDuration()),
//               Expanded(flex: 0,child: PlaybackSpeedButton()),
//             ],
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: CommonColors.primaryColor,
//             progressColors: const ProgressBarColors(
//               playedColor: CommonColors.primaryColor,
//               handleColor: CommonColors.primaryColor,
//             ),
//             onReady: () {
//               setState(() {
//                 isLoading = false;
//               });
//             },
//           ),
//         ),
//         if (isLoading)
//           const Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 2,
//             ),
//           ),
//         // Align(
//         //   alignment: Alignment.center,
//         //   child: !isPlaying && widget.isButtonVisible!
//         //       ? IconButton(
//         //           color: Colors.white,
//         //           icon: Icon(_controller.value.isPlaying
//         //               ? Icons.pause
//         //               : Icons.play_arrow),
//         //           onPressed: () {
//         //             setState(() {
//         //               if (_controller.value.isPlaying) {
//         //                 _controller.pause();
//         //               } else {
//         //                 _controller.play();
//         //               }
//         //             });
//         //           },
//         //         )
//         //       : const SizedBox.shrink(),
//         // ),
//         Align(
//           alignment: Alignment.topRight,
//           child: IconButton(
//             icon: Icon(Icons.fullscreen,color: CommonColors.mWhite,),
//             onPressed: () {
//               SystemChrome.setPreferredOrientations([
//                 DeviceOrientation.landscapeRight,
//                 DeviceOrientation.landscapeLeft,
//               ]).then((_) {
//                 Navigator.of(context).push(MaterialPageRoute<void>(
//                   builder: (BuildContext context) {
//                     return Scaffold(
//                       body: Center(
//                         child: YoutubePlayer(
//                           controller: _controller,
//                           bottomActions: [
//                             Expanded(flex: 0, child: CurrentPosition()),
//                             Expanded(
//                               flex: 1,
//                               child: ProgressBar(
//                               ),
//                             ),
//                             Expanded(flex: 0,child: RemainingDuration()),
//                             Expanded(flex: 0,child: PlaybackSpeedButton()),
//                           ],
//                           showVideoProgressIndicator: true,
//                           progressIndicatorColor: CommonColors.primaryColor,
//                           progressColors: const ProgressBarColors(
//                             playedColor: CommonColors.primaryColor,
//                             handleColor: CommonColors.primaryColor,
//                           ),
//                           onReady: () {
//                             setState(() {
//                               isLoading = false;
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 )).then((_) {
//                   SystemChrome.setPreferredOrientations([
//                     DeviceOrientation.portraitUp,
//                   ]);
//                 });
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
