import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

class CustomOptionMultiButton extends StatelessWidget {
  CustomOptionMultiButton({
    super.key,
    required this.text,
    this.onTap,
    required this.isSelected,
  });

  final String text;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? CommonColors.blueShade : CommonColors.mWhite,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: isSelected ? CommonColors.purple : CommonColors.greyText,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Flexible(
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  color: isSelected ? Colors.purple : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
