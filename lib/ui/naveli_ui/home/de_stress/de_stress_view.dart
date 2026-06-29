import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/services/api_url.dart';
import 'package:naveli_2023/ui/naveli_ui/home/de_stress/de_stress_info.dart';
import 'package:naveli_2023/ui/naveli_ui/home/de_stress/de_stress_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';

class DeStressView extends StatefulWidget {
  const DeStressView({super.key});

  @override
  State<DeStressView> createState() => _DeStressViewState();
}

class _DeStressViewState extends State<DeStressView> {
  late DeStressViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        mViewModel = Provider.of<DeStressViewModel>(context, listen: false);
        mViewModel.onScreenInit(ApiUrl.DE_STRESS_VIDEO_URL);
      }
    });
  }

  @override
  void dispose() {
    mViewModel.onScreenDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: const CommonAppBar(title: ""),
        body: Consumer<DeStressViewModel>(
          builder: (context, vModel, child) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: vModel.isVideoActive
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                if (vModel.betterPlayerController != null &&
                                    vModel.isInitialized)
                                  AspectRatio(
                                    aspectRatio: vModel
                                        .betterPlayerController!
                                        .videoPlayerController!
                                        .value
                                        .aspectRatio,
                                    child: BetterPlayer(
                                      controller:
                                          vModel.betterPlayerController!,
                                    ),
                                  )
                                else
                                  Image.asset(
                                    LocalImages.img_destress_img,
                                    fit: BoxFit.contain,
                                  ),
                                if (vModel.isVideoLoading)
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: CommonColors.primaryColor,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Image.asset(
                              LocalImages.img_destress_img,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                  if (!vModel.isVideoActive)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context)!.destressYourself,
                          style: const TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            push(const DeStressInfo());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: CommonColors.primaryColor
                                  .withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              size: 18,
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (!vModel.isVideoActive)
                    Text(
                      S.of(context)!.takeAMomentToRelax,
                      style: const TextStyle(
                        color: CommonColors.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (!vModel.isVideoActive) kCommonSpaceV30,
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<DeStressViewModel>(
          builder: (context, vModel, child) {
            return Padding(
              padding: kCommonAllBottomPadding,
              child: Row(
                children: [
                  vModel.isVideoActive
                      ? Expanded(
                          child: PrimaryButton(
                            onPress: () {
                              vModel.stopVideo();
                            },
                            label: S.of(context)!.stop,
                          ),
                        )
                      : Expanded(
                          child: PrimaryButton(
                            onPress: () {
                              vModel.startVideo(ApiUrl.DE_STRESS_VIDEO_URL);
                            },
                            label: S.of(context)!.start,
                          ),
                        ),
                  kCommonSpaceV30,
                  kCommonSpaceV30,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
