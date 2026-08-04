import 'package:flutter/material.dart';

import '../utils/common_colors.dart';

class CommonProfileMenu extends StatelessWidget {
  final String text;
  final String? text2;
  final bool isLast;
  final GestureTapCallback? onTap;
  final Color? color;
  final Color? underLineColor;
  final String? imagePath;
  final double? imageSize;

  const CommonProfileMenu(
      {super.key,
      required this.text,
      this.text2,
      required this.isLast,
      this.onTap,
      this.color,
      this.underLineColor,
      this.imagePath,
      this.imageSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: ShapeDecoration(
              color: CommonColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: CommonColors.mGrey300,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            padding: const EdgeInsets.only(left: 3.0),
            // margin: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: ShapeDecoration(
                color: color != null ? color : Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          text2 ?? '',
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (imagePath != null && imagePath!.isNotEmpty) ...[
                        Image.asset(
                          imagePath!,
                          width: imageSize ?? 35,
                          height: imageSize ?? 35,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Icon(
                        Icons.chevron_right,
                        color: CommonColors.blackArrow, //CommonColors.primaryColor,
                        size: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Container(
            height: 20,
            color: underLineColor ?? CommonColors.mWhite,
          )
      ],
    );
  }
}
