import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';

class SavedPostScreen extends StatelessWidget {
  const SavedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ScaffoldBG(
      child: Scaffold(
        appBar: CommonAppBar(
          title: S.of(context)!.savedPosts,
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.blackColor,
          style: TextStyle(
            color: CommonColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
