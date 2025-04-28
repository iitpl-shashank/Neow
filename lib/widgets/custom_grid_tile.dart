import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/common_utils.dart';
import '../utils/constant.dart';
import 'common_box.dart';

class CustomGridTile extends StatelessWidget {
  final String count;
  final String title;

  const CustomGridTile({required this.count, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonBox(
          padding: EdgeInsets.all(Screen.width() * 0.1),
          color: const Color(0xFFFAF5F5),
          child: Center(
            child: Text(
              count,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: getAppStyle(
                fontSize: 30,
                color: CommonColors.primaryColor,
              ),
            ),
          ),
        ),
        kCommonSpaceV10,
        Text(
          title,
          textAlign: TextAlign.center,
          style: getAppStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
