import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

class CommonAddSticker extends StatelessWidget {
  const CommonAddSticker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: CommonColors.primaryLite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.collections_rounded, color: CommonColors.mGrey),
          Text(
            'Add Sticker',
            style: TextStyle(
              color: CommonColors.mGrey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
