import 'package:flutter/material.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/models/saved_post_master.dart';
import 'package:naveli_2023/ui/naveli_ui/home/all_about_periods/saved_post_detail_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/all_about_periods/saved_post_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../health_mix/video_particular.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  late SavedPostViewModel mViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getSavedPostsApi(isRefresh: true);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      mViewModel.getSavedPostsApi();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SavedPostViewModel>(context);
    return SafeArea(
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.savedPosts,
            bgColor: CommonColors.mTransparent,
            iconColor: CommonColors.blackColor,
            style: const TextStyle(
              color: CommonColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: mViewModel.isLoading && mViewModel.savedPostsList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.primaryColor,
                  ),
                )
              : mViewModel.savedPostsList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border_rounded,
                            size: 80,
                            color: CommonColors.primaryColor.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S.of(context)!.noData,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CommonColors.blackColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      color: CommonColors.primaryColor,
                      onRefresh: () async {
                        await mViewModel.getSavedPostsApi(isRefresh: true);
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: mViewModel.savedPostsList.length +
                            (mViewModel.isLoading ? 1 : 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        itemBuilder: (context, index) {
                          if (index == mViewModel.savedPostsList.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: CircularProgressIndicator(
                                  color: CommonColors.primaryColor,
                                ),
                              ),
                            );
                          }

                          SavedPost item = mViewModel.savedPostsList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                push(SavedPostDetailView(
                                  item: item,
                                  index: index,
                                ));
                              },
                              child: Container(
                                width: kDeviceWidth,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: CommonColors.mWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x1F000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                      spreadRadius: 4,
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.title ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              item.diffrenceTime ?? '',
                                              style: const TextStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (item.fileType == 'image')
                                      Container(
                                        height: 80,
                                        width: 80,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: CommonColors.mGrey
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(item.posts ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (item.fileType == 'link')
                                      Container(
                                        height: 80,
                                        width: 80,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: CommonColors.mGrey
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: IgnorePointer(
                                            child: VideoPlayerScreen(
                                              link: item.posts ??
                                                  "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}
