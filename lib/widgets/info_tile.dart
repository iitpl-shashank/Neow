import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String infoText;

  const InfoTile({required this.title, required this.infoText, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getAppStyle(
            fontSize: 16,
          ),
        ),
        kCommonSpaceV5,
        Text(
          infoText,
          style: getAppStyle(
            color: CommonColors.primaryColor,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
