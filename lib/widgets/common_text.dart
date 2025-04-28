import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final String value;

  // Constructor
  const CustomTextWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title : ',
          style: getAppStyle(
            color: CommonColors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: getAppStyle(
            color: CommonColors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    );
  }
}
