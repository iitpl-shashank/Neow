import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

class CustomOptionButton extends StatelessWidget {
  const CustomOptionButton({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CommonColors.primaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
