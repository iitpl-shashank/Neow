import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../utils/common_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String link;

  const VideoPlayerScreen({
    required this.link,
    super.key,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        hideThumbnail: true,
        showLiveFullscreenButton: false,
      ),
    )..addListener(() {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: CommonColors.primaryColor,
            progressColors: const ProgressBarColors(
              playedColor: CommonColors.primaryColor,
              handleColor: CommonColors.primaryColor,
            ),
            onReady: () {
              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.fullscreen, color: CommonColors.mWhite),
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]).then((_) {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      body: Center(
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: CommonColors.primaryColor,
                          progressColors: const ProgressBarColors(
                            playedColor: CommonColors.primaryColor,
                            handleColor: CommonColors.primaryColor,
                          ),
                          onReady: () {
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                    );
                  },
                )).then((_) {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);
                });
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
