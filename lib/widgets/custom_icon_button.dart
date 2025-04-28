import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';
import 'common_box.dart';

class CustomIconBtn extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final IconData icon;

  const CustomIconBtn(
      {required this.onTap,
      required this.label,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBox(
      padding: const EdgeInsets.all(10),
      onTap: onTap,
      color: CommonColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: getAppStyle(
              color: CommonColors.mWhite,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          kCommonSpaceH15,
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: CommonColors.mWhite),
            child: Icon(
              icon,
              color: CommonColors.primaryColor,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
