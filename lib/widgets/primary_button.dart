import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';

class PrimaryButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? buttonColor;
  final Color? borderColor;
  final Function()? onPress;
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final bool? boxshadow;
  final double? lblSize;
  final BorderRadius? borderRadius;

  const PrimaryButton({
    this.label,
    this.onPress,
    this.labelColor,
    this.buttonColor,
    this.height,
    this.width,
    this.alignment,
    this.padding,
    this.boxshadow = false,
    this.lblSize,
    this.borderRadius,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      height: height ?? 48,
      clipBehavior: Clip.antiAlias,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        border: borderColor != null
            ? Border.all(
                color: borderColor ?? CommonColors.mTransparent,
                width: 1,
              )
            : null,
        color: buttonColor ?? CommonColors.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(30.0),
        boxShadow: boxshadow!
            ? [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 6,
                  spreadRadius: 0,
                  color:
                      labelColor ?? CommonColors.primaryColor.withOpacity(0.4),
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          splashColor: CommonColors.blackColor.withOpacity(0.2),
          highlightColor: CommonColors.blackColor.withOpacity(0.2),
          child: Container(
            alignment: alignment ?? Alignment.center,
            padding: padding ?? EdgeInsets.zero,
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: getAppStyle(
                color: labelColor ?? CommonColors.mWhite,
                fontSize: lblSize ?? 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? buttonColor;
  final Function()? onPress;
  final double? height;
  final double? width;
  final bool? isRounded;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  const SecondaryButton({
    this.label,
    this.onPress,
    this.labelColor,
    this.buttonColor,
    this.height,
    this.width,
    this.isRounded = false,
    this.alignment,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      height: height ?? 48,
      clipBehavior: Clip.antiAlias,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          color: buttonColor ?? CommonColors.mWhite,
          borderRadius: isRounded!
              ? BorderRadius.circular(50)
              : BorderRadius.circular(8.0),
          border: isRounded!
              ? Border.all(color: CommonColors.primaryColor)
              : Border.all(color: CommonColors.mTransparent)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          splashColor: CommonColors.blackColor.withOpacity(0.2),
          highlightColor: CommonColors.blackColor.withOpacity(0.2),
          child: Container(
            alignment: alignment ?? Alignment.center,
            padding: padding ?? EdgeInsets.zero,
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: getAppStyle(
                color: labelColor ?? CommonColors.mWhite,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
