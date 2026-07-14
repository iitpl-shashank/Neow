import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/models/saved_post_master.dart';
import 'package:naveli_2023/ui/naveli_ui/home/all_about_periods/saved_post_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../health_mix/video_particular.dart';

class SavedPostDetailView extends StatefulWidget {
  final SavedPost item;
  final int index;

  const SavedPostDetailView({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  State<SavedPostDetailView> createState() => _SavedPostDetailViewState();
}

class _SavedPostDetailViewState extends State<SavedPostDetailView> {
  late SavedPostViewModel mViewModel;

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SavedPostViewModel>(context);
    return SafeArea(
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: '',
            bgColor: CommonColors.mTransparent,
            iconColor: CommonColors.blackColor,
            style: const TextStyle(
              color: CommonColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Container(
                          width: kDeviceWidth / 1,
                          clipBehavior: Clip.antiAlias,
                          decoration: const ShapeDecoration(
                            color: CommonColors.mWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (widget.item.fileType == 'image')
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute<void>(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.network(
                                            height: kDeviceHeight / 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            widget.item.posts ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    height: kDeviceHeight / 2,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(widget.item.posts ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            CommonColors.mTransparent,
                                            CommonColors.blackColor
                                                .withOpacity(0.7)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.item.title ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: CommonColors.mWhite,
                                              fontSize: 20,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.item.diffrenceTime ?? '',
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: CommonColors.mWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (widget.item.fileType == 'link')
                                SizedBox(
                                  height: kDeviceHeight / 4,
                                  child: VideoPlayerScreen(
                                    link: widget.item.posts ??
                                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                  ),
                                ),
                              kCommonSpaceV20,
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Mock/No-op heart for saved posts details
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.heart,
                                            color: CommonColors.blackColor,
                                          ),
                                        ),
                                        kCommonSpaceH3,
                                        IconButton(
                                          onPressed: () {
                                            if (widget.item.fileType ==
                                                "image") {
                                              shareNetworkImage(
                                                widget.item.posts,
                                                text: widget.item.description,
                                              );
                                            } else if (widget.item.fileType ==
                                                "link") {
                                              share(
                                                widget.item.posts,
                                                text: widget.item.description,
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.share_outlined,
                                            color: CommonColors.blackColor,
                                          ),
                                        ),
                                        kCommonSpaceH3,
                                        IconButton(
                                          onPressed: () {
                                            mViewModel.removeSavedPostApi(
                                              postId: widget.item.id,
                                              index: widget.index,
                                            );
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.bookmark_added_rounded,
                                            color: CommonColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.check_circle_rounded,
                                            color: CommonColors.greenColor,
                                          ),
                                        ),
                                        Text(
                                          S.of(context)!.reviewedByExperts,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  widget.item.description ?? '',
                                  style: const TextStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
