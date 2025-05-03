import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../utils/constant.dart';

class CommonGenderSelectBox extends StatefulWidget {
  final String imagePath;
  final String? text;
  final bool isSelected;
  final bool isBoxFit;
  final double? height;
  final bool isTitle;
  final bool isShowDefaultBorder;
  final double? width;
  final void Function()? onTap;

  const CommonGenderSelectBox({
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
  State<CommonGenderSelectBox> createState() => _CommonGenderSelectBoxState();
}

class _CommonGenderSelectBoxState extends State<CommonGenderSelectBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: kDeviceWidth / 1.3,
            /*height: widget.height ?? 120, */
            padding: const EdgeInsets.only(
              left: 20,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color:
                  widget.isSelected ? Color(0xFFFAEEFF) : CommonColors.mWhite,
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              border: Border.all(
                width: 1,
                color: widget.isSelected
                    ? CommonColors.primaryColor
                    : CommonColors.darkPrimaryColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                widget.text ?? '',
                style: getAppStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w200,
                    color: widget.isSelected
                        ? CommonColors.primaryColor
                        : CommonColors.darkPrimaryColor),
              ), /* Image.asset(
                widget.imagePath,
                // width: 100.0,
                // height: 100.0,
                fit: widget.isBoxFit ? BoxFit.cover : null,
              ), */
            ),
          ),
        ),
        // kCommonSpaceV5,
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
