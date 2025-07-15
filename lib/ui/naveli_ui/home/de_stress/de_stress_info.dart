import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/de_stress/info_items.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';

class DeStressInfo extends StatelessWidget {
  const DeStressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.breathingTechnique,
        bgColor: CommonColors.mTransparent,
        iconColor: CommonColors.blackColor,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoItems(
              titleIcon: "🧘‍♀️",
              title: S.of(context)!.technique,
              imageUrl: "assets/images/destress_technique.png",
              points: [
                S.of(context)!.techniquePoint1,
                S.of(context)!.techniquePoint2,
                S.of(context)!.techniquePoint3,
                S.of(context)!.techniquePoint4,
                S.of(context)!.techniquePoint5,
                S.of(context)!.techniquePoint6,
              ],
            ),
            InfoItems(
              titleIcon: "🌿",
              title: S.of(context)!.benefits,
              points: [
                S.of(context)!.benefitPoint1,
                S.of(context)!.benefitPoint2,
                S.of(context)!.benefitPoint3,
                S.of(context)!.benefitPoint4,
                S.of(context)!.benefitPoint5,
              ],
            ),
            InfoItems(
              titleIcon: "⚠",
              title: S.of(context)!.disclaimer,
              points: [
                S.of(context)!.disclaimerPoint1,
                S.of(context)!.disclaimerPoint2,
                S.of(context)!.disclaimerPoint3,
                S.of(context)!.disclaimerPoint4,
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
