import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../health_mix/video_particular.dart';
import '../you_know/all_posts_model.dart';

class NutritionView extends StatefulWidget {
  const NutritionView({super.key});

  @override
  State<NutritionView> createState() => _NutritionViewState();
}

class _NutritionViewState extends State<NutritionView> {
  late AllPostsModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAllPostsApi(parentTitleId: 4, filterBy: 'newest');
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AllPostsModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.nutrition,
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.primaryColor,
          style: getGoogleFontStyle(
            color: CommonColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  S.of(context)!.eatGlowRepeat,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kCommonSpaceV20,
                Image.asset(
                  LocalImages.img_nutrition_post,
                  fit: BoxFit.cover,
                ),
                kCommonSpaceV20,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mViewModel.postsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: kDeviceWidth / 1,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: CommonColors.mWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
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
                            if (mViewModel.postsList[index].fileType == 'image')
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          mViewModel.postsList[index].posts ??
                                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  height: kDeviceHeight / 4.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mViewModel
                                              .postsList[index].posts ??
                                          "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            if (mViewModel.postsList[index].fileType == 'link')
                              // Text(
                              //   mViewModel.postsList[index].posts ?? 'no video',
                              //   style: getAppStyle(
                              //     color: CommonColors.mGrey,
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w400,
                              //     height: 1,
                              //   ),
                              // ),
                              //   VideoPlayerScreen(
                              //     link: mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                              //     // isButtonVisible: true,
                              //     isFillAvailableSpace: false,
                              //     isLoop: true,
                              //     isMute: true,
                              //   ),
                              SizedBox(
                                height: kDeviceHeight / 4,
                                child: VideoPlayerScreen(
                                  link: mViewModel.postsList[index].posts ??
                                      "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                  // isFillAvailableSpace: false,
                                  // isLoop: true,
                                  // isMute: false,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                mViewModel.postsList[index].description!,
                                style: getAppStyle(
                                  color: CommonColors.mGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: mViewModel.postsList.length,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 5),
                //       child: Container(
                //         width: 390,
                //         height: kDeviceHeight / 3,
                //         clipBehavior: Clip.antiAlias,
                //         decoration: ShapeDecoration(
                //           color: CommonColors.mWhite,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           shadows: [
                //             BoxShadow(
                //               color: Color(0x3F000000),
                //               blurRadius: 8,
                //               offset: Offset(0, 2),
                //               spreadRadius: 0,
                //             )
                //           ],
                //         ),
                //         child: Column(
                //           children: [
                //             Container(
                //               width: 390,
                //               height: kDeviceHeight / 4.5,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                   image: NetworkImage(mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //               child: Align(
                //                 alignment: Alignment.topRight,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: CommonColors.mWhite
                //                     ),
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(4.0),
                //                       child: Icon(
                //                         Icons.favorite_outlined,
                //                         size: 25,
                //                         color: CommonColors.greenColor,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Flexible(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   mViewModel.postsList[index].description!,
                //                   style: getAppStyle(
                //                     color: CommonColors.mGrey,
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1,
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
