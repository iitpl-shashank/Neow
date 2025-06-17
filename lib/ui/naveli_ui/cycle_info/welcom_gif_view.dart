import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../common_ui/singin/signin_view_model.dart';
import '../profile/your_naveli/your_naveli_view_model.dart';

class WelComeGifView extends StatefulWidget {
  final bool isFromSplash;

  const WelComeGifView({
    super.key,
    this.isFromSplash = true,
  });

  @override
  State<WelComeGifView> createState() => _WelComeGifViewState();
}

class _WelComeGifViewState extends State<WelComeGifView> {
  @override
  void initState() {
    super.initState();
    if (!widget.isFromSplash) {
      Future.delayed(const Duration(seconds: 3), () async {
        await SignInViewModel().login(
            userType: gUserType,
            mViewModel:
                Provider.of<YourNaveliViewModel>(context, listen: false));
      });
    } else {
      Future.delayed(const Duration(milliseconds: 1), () {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      bgColor: CommonColors.bglightPinkColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: kCommonAllTopBottomPadding,
          child: globalUserMaster == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    kCommonSpaceV50,
                    Stack(children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              height: 170,
                              width: 200,
                              padding: const EdgeInsets.only(
                                top: 30,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(LocalImages.welcome_bubble),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (gUserType == AppConstants.NEOWME) ...[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${S.of(context)!.welcomeViewText} ${globalUserMaster == null || !widget.isFromSplash ? "" : ""}',
                                          style: const TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            globalUserMaster == null ||
                                                    !widget.isFromSplash
                                                ? 'NeoW'
                                                : 'NeoW',
                                            style: TextStyle(
                                              color: CommonColors.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          kCommonSpaceH5,
                                          Flexible(
                                            child: Text(
                                              globalUserMaster?.name
                                                      .toString()
                                                      .split(' ')[0] ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color:
                                                      CommonColors.primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (gUserType == AppConstants.BUDDY) ...[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${S.of(context)!.welcomeViewText} ${globalUserMaster == null || !widget.isFromSplash ? globalUserMaster?.name ?? '' : ""}',
                                          style: const TextStyle(
                                            color: CommonColors.blackColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            globalUserMaster == null ||
                                                    !widget.isFromSplash
                                                ? 'for '
                                                : '${globalUserMaster?.name ?? ''} for',
                                            style: const TextStyle(
                                              color: CommonColors.blackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            globalUserMaster == null ||
                                                    !widget.isFromSplash
                                                ? ' NeoW Buddy'
                                                : ' NeoW Buddy',
                                            style: const TextStyle(
                                              color: CommonColors.primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (gUserType ==
                                        AppConstants.CYCLE_EXPLORER) ...[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${S.of(context)!.welcomeViewText} ${globalUserMaster == null || !widget.isFromSplash ? globalUserMaster?.name ?? '' : " \n${globalUserMaster?.name}"}',
                                          style: const TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    if (globalUserMaster == null) ...[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          S.of(context)!.welcomeViewText,
                                          style: TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'NeoW',
                                            style: getGoogleFontStyle(
                                              color: CommonColors.color_FF3C69,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          kCommonSpaceH5,
                                          Flexible(
                                            child: Text(
                                              (globalUserMaster?.name != null ||
                                                      globalUserMaster?.name !=
                                                          '')
                                                  ? globalUserMaster?.name ?? ""
                                                  : '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color:
                                                    CommonColors.primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ]))),
                    ]),
                    Center(
                      child: Image.asset(
                        LocalImages.gif_neowme_moving,
                        fit: BoxFit.cover,
                        height: kDeviceHeight / 1.4,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
