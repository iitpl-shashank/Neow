import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonFilterContainer extends StatelessWidget {
  final String title;
  final bool isIcon;
  final bool isSelected;
  final GestureTapCallback? onTap;
  const CommonFilterContainer({super.key, required this.title, this.isIcon = false, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CommonColors.bglightPinkColor,
              border: isSelected ? Border.all(width: 1,color: CommonColors.primaryColor) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 15,left: 15),
            child: Row(
              children: [
                Text(
                  title,
                  style: getAppStyle(
                      color: CommonColors.primaryColor,
                      height: 1,
                    fontWeight: FontWeight.w500
                  ),
                ),
               isIcon ? const Icon(Icons.favorite,color: CommonColors.mRed,) : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
