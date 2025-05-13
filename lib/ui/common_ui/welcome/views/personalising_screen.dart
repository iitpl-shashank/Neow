import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';

class PersonalisingScreen extends StatelessWidget {
  const PersonalisingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    LocalImages.gif_star,
                    width: kDeviceWidth / 1.3,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    LocalImages.img_sprinkle,
                    width: kDeviceWidth / 1.3,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            kCommonSpaceV20,
            Text(
              S.of(context)!.personalisingExp,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
