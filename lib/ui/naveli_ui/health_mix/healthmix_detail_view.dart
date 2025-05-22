import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/health_mix_view_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../generated/i18n.dart';
import '../../../models/health_mix_posts_master.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../widgets/common_appbar.dart';

class HealthmixDetailView extends StatefulWidget {
  const HealthmixDetailView({
    super.key,
    required this.post,
    required this.postIndex,
  });
  final HealthMixPosts post;
  final int postIndex;

  @override
  State<HealthmixDetailView> createState() => _HealthmixDetailViewState();
}

class _HealthmixDetailViewState extends State<HealthmixDetailView> {
  late YoutubePlayerController _youtubeController;
  late HealthMixViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
    if (widget.post.mediaType == "link") {
      final videoId = YoutubePlayer.convertUrlToId(widget.post.media ?? "");
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          showLiveFullscreenButton: true,
          autoPlay: true,
          mute: false,
        ),
      );
      _youtubeController.addListener(() {
        final isFullScreen = _youtubeController.value.isFullScreen;
        Provider.of<HealthMixViewModel>(context, listen: false)
            .setFullScreen(isFullScreen);

        if (!isFullScreen) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.post.mediaType == "link") {
      _youtubeController.dispose();
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = Provider.of<HealthMixViewModel>(context).isFullScreen;
    mViewModel = Provider.of<HealthMixViewModel>(context);

    return ScaffoldBG(
      bgColor: CommonColors.mWhite,
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: isFullScreen
            ? null
            : CommonAppBar(
                title: S.of(context)!.postDetails,
                bgColor: CommonColors.mTransparent,
                iconColor: CommonColors.blackColor,
                style: const TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 25, left: 10, right: 10, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.post.mediaType == "link")
                  YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                  )
                else
                  Image.network(
                    widget.post.media ??
                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: () {
                        mViewModel.likeHealthMixPostApi(
                            healthMixId: widget.post.id,
                            isLike: mViewModel.isLikedList[widget.postIndex]
                                ? 0
                                : 1);
                        setState(() {
                          mViewModel.isLikedList[widget.postIndex] =
                              !mViewModel.isLikedList[widget.postIndex];
                        });
                      },
                      icon: Icon(
                        mViewModel.isLikedList[widget.postIndex]
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    kCommonSpaceH3,
                    IconButton(
                      onPressed: () {
                        if (widget.post.mediaType == "link") {
                          share(
                            widget.post.media,
                            text: widget.post.description,
                          );
                        } else if (widget.post.mediaType == "image") {
                          shareNetworkImage(
                            widget.post.media,
                            text: widget.post.description,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.share_outlined,
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    kCommonSpaceH3,
                    IconButton(
                      onPressed: () async {
                        await mViewModel.saveHealthMixPost(
                          healthMixId: widget.post.id ?? 0,
                          isSaved: 1,
                        );
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: CommonColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  S.of(context)!.tags,
                  style: const TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.post.hashtags}",
                  style: const TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context)!.description,
                  style: const TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.post.description ?? "",
                  style: const TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
