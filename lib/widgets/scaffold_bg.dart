import 'package:flutter/material.dart';

import '../utils/common_colors.dart';

class ScaffoldBG extends StatelessWidget {
  final Widget? child;
  final Color? bgColor;
  const ScaffoldBG({
    super.key,
    this.child,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: CommonColors.mWhite,
        /* image: const DecorationImage(
          image: AssetImage(LocalImages.img_background),
          // image: NetworkImage("https://www.itakeyou.co.uk/wp-content/uploads/2023/01/valentines-wallpaper-1-1.jpg"),
          fit: BoxFit.cover
        ), */
      ),
      child: child,
    );
  }
}
