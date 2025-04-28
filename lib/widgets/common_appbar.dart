import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonAppBar extends StatelessWidget implements PreferredSize {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? style;
  final PreferredSizeWidget? bottom;
  final bool? automaticallyImplyLeading;

  const CommonAppBar({
    this.leading,
    required this.title,
    this.actions,
    this.centerTitle,
    this.bgColor,
    this.bottom,
    this.textColor,
    this.iconColor,
    this.style,
    this.automaticallyImplyLeading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      backgroundColor: bgColor ?? CommonColors.mTransparent,
      elevation: 0,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      centerTitle: centerTitle ?? true,
      iconTheme: IconThemeData(
        color: iconColor ?? CommonColors.blackColor,
      ),
      title: Text(
        title!,
        style: style ??
            TextStyle(
              color: CommonColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
