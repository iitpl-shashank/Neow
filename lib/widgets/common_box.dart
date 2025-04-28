import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Function()? onTap;

  const CommonBox({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        color: color ?? CommonColors.mWhite,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          splashColor: onTap == null
              ? Colors.transparent
              : Colors.black45.withOpacity(0.080),
          radius: 800,
          highlightColor: onTap == null
              ? Colors.transparent
              : Colors.black45.withOpacity(0.080),
          child: Container(
            padding: padding ?? kCommonScreenPadding,
            margin: margin ?? const EdgeInsets.all(0),
            child: child,
          ),
        ),
      ),
    );
  }
}

class OneSidedShadowBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Function()? onTap;

  const OneSidedShadowBox({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(18.0),
        color: color ?? CommonColors.primaryColor.withOpacity(.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.300),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(15.0),
          color: color ?? CommonColors.mWhite,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () {},
            splashColor: onTap == null
                ? Colors.transparent
                : Colors.black45.withOpacity(0.080),
            radius: 800,
            highlightColor: onTap == null
                ? Colors.transparent
                : Colors.black45.withOpacity(0.080),
            child: Container(
              padding: padding ?? kCommonScreenPadding,
              margin: margin ?? const EdgeInsets.all(0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
