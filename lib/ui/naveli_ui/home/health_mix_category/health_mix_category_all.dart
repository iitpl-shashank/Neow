import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/post_list.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../../../widgets/healthmix_category_card.dart';
import 'package:provider/provider.dart';

import '../home_view_model.dart';

class HealthMixCategoryAll extends StatelessWidget {
  const HealthMixCategoryAll({super.key});

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<HomeViewModel>(context);

    return ScaffoldBG(
      bgColor: CommonColors.mWhite,
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: "Explore HealthMix",
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.blackColor,
          style: const TextStyle(
            color: CommonColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 25, left: 10, right: 10, top: 15),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: mViewModel.healthMixCategoryList.length,
            itemBuilder: (context, index) {
              final category = mViewModel.healthMixCategoryList[index];
              return HealthmixCategoryCard(
                title: category.name ?? "",
                imagePath: category.iconUrl ?? "",
                backgroundColor: const Color(0xFFFFEDED),
                onTap: () {
                  push(PostList(
                    position: 0,
                    selectedTabIndex: category.id ?? 0,
                    postTitle: category.name ?? "",
                  ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
