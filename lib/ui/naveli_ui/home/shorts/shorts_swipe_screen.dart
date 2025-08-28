import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/ui/naveli_ui/home/shorts/shorts_view_model.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:naveli_2023/models/shorts_model.dart';

class ShortsSwipeScreen extends StatefulWidget {
  final List<ShortsData> shortsList;
  final int initialIndex;
  final Future<void> Function() fetchMore;

  const ShortsSwipeScreen({
    super.key,
    required this.shortsList,
    required this.initialIndex,
    required this.fetchMore,
  });

  @override
  State<ShortsSwipeScreen> createState() => _ShortsSwipeScreenState();
}

class _ShortsSwipeScreenState extends State<ShortsSwipeScreen> {
  late PageController _pageController;
  late int currentIndex;
  final Map<int, VideoPlayerController> _controllers = {};
  late ShortsViewModel shortsViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shortsViewModel.attachedContext(context);
    });
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
    _initController(currentIndex);
    _initController(currentIndex + 1);
    _initController(currentIndex - 1);
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initController(int index) async {
    if (index < 0 || index >= widget.shortsList.length) return;
    if (_controllers[index] != null) return;
    final url = widget.shortsList[index].video ?? '';
    final controller = VideoPlayerController.network(url);
    await controller.initialize();
    controller.setLooping(true);
    if (index == currentIndex) controller.play();
    _controllers[index] = controller;
    setState(() {});
  }

  void _disposeController(int index) {
    if (_controllers[index] != null) {
      _controllers[index]!.dispose();
      _controllers.remove(index);
    }
  }

  void _onPageChanged(int index) async {
    setState(() {
      currentIndex = index;
    });
    // Play current, pause others
    _controllers.forEach((i, c) {
      if (i == index) {
        c.play();
      } else {
        c.pause();
      }
    });
    // Preload next and previous
    await _initController(index + 1);
    await _initController(index - 1);
    // Optionally dispose far controllers
    _disposeController(index - 2);
    _disposeController(index + 2);

    // Pagination
    if (index >= widget.shortsList.length - 3) {
      await widget.fetchMore();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    shortsViewModel = Provider.of<ShortsViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.shortsList.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          return controller != null && controller.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.value.isPlaying
                          ? controller.pause()
                          : controller.play();
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(controller),
                      if (!controller.value.isPlaying)
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 64,
                        ),
                      Positioned(
                        left: 16,
                        top: 48,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 24),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 80,
                        right: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/icon/neow_icon.png'),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Neow India',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(blurRadius: 8, color: Colors.black)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 48,
                        right: 100,
                        child: Text(
                          widget.shortsList[index].description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(blurRadius: 8, color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 48,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                final isCurrentlyLiked =
                                    widget.shortsList[index].isLiked ?? false;
                                final result =
                                    await shortsViewModel.likeOrDislikeShort(
                                  shortId:
                                      widget.shortsList[index].id.toString(),
                                  isLike: !isCurrentlyLiked,
                                );
                                if (result) {
                                  setState(() {
                                    widget.shortsList[index].isLiked =
                                        !isCurrentlyLiked;
                                    if (widget.shortsList[index].isLiked ==
                                        true) {
                                      widget.shortsList[index].likesCount =
                                          (widget.shortsList[index]
                                                      .likesCount ??
                                                  0) +
                                              1;
                                    } else {
                                      widget.shortsList[index].likesCount =
                                          (widget.shortsList[index]
                                                      .likesCount ??
                                                  1) -
                                              1;
                                      if (widget.shortsList[index].likesCount! <
                                          0) {
                                        widget.shortsList[index].likesCount = 0;
                                      }
                                    }
                                  });
                                }
                              },
                              child: SvgPicture.asset(
                                (widget.shortsList[index].isLiked ?? true)
                                    ? LocalSvgs.icHeartFill
                                    : LocalSvgs.icHeartOutline,
                                height: 25,
                                width: 23,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              formatNumberToShortString(
                                widget.shortsList[index].likesCount ?? 0,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 23),
                            InkWell(
                              onTap: () {
                                final shortId = widget.shortsList[index].id;
                                final page = (index ~/ 5) +
                                    1; // Assuming 5 shorts per page
                                final type = 'latest'; // Or your current type
                                final shareUrl =
                                    'https://lab1.invoidea.work/neow/shorts?shortId=$shortId&page=$page&type=$type';
                                Share.share('Check out this short: $shareUrl');
                              },
                              child: SvgPicture.asset(
                                LocalSvgs.icShare,
                                height: 19,
                                width: 22,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    if (widget.shortsList[index].image != null)
                      Image.network(
                        widget.shortsList[index].image!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.black,
                            child: Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.grey, size: 64),
                            ),
                          );
                        },
                      ),
                    const Center(child: CircularProgressIndicator()),
                  ],
                );
        },
      ),
    );
  }
}
