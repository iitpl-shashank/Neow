import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../utils/constant.dart';

class CommonRelationSelectBox extends StatefulWidget {
  final String imagePath;
  final String? text;
  final bool isSelected;
  final bool isBoxFit;
  final double? height;
  final bool isTitle;
  final bool isShowDefaultBorder;
  final double? width;
  final void Function()? onTap;

  const CommonRelationSelectBox({
    super.key,
    required this.imagePath,
    this.text,
    required this.isSelected,
    this.onTap,
    this.isBoxFit = false,
    this.height,
    this.isTitle = true,
    this.width,
    this.isShowDefaultBorder = false,
  });

  @override
  State<CommonRelationSelectBox> createState() =>
      _CommonRelationSelectBoxState();
}

class _CommonRelationSelectBoxState extends State<CommonRelationSelectBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kCommonSpaceV5,
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 150,
            height: 190,
            padding: const EdgeInsets.all(5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? const Color(0xFFFAEEFF)
                  : CommonColors.mWhite,
              boxShadow: [
                widget.isSelected
                    ? const BoxShadow(
                        color: CommonColors.primaryColor,
                        blurRadius: 20.0,
                      )
                    : const BoxShadow(
                        color: CommonColors.mTransparent,
                        blurRadius: 20.0,
                      )
              ],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 1,
                color: widget.isSelected
                    ? CommonColors.primaryColor
                    : CommonColors.mGrey.withOpacity(0.3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Image.asset(
                  widget.imagePath,
                  width: 130.0,
                  height: 130.0,
                  fit: widget.isBoxFit ? BoxFit.cover : BoxFit.contain,
                ),
                const Spacer(), // Pushes the text to the bottom
                // Text at the bottom center
                Text(
                  widget.text ?? '',
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: widget.isSelected
                        ? CommonColors.primaryColor
                        : CommonColors.mGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        kCommonSpaceV5,
        widget.isTitle
            ? Text(
                '',
                style: getAppStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected
                        ? CommonColors.primaryColor
                        : CommonColors.darkPrimaryColor),
              )
            : Container(
                height: 1,
              ),
      ],
    );
  }
}
