import 'package:flutter/material.dart';

import '../utils/common_colors.dart';

class CommonNextIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const CommonNextIconButton({super.key,
    required this.icon,
    required this.onPressed,
    this.color = CommonColors.primaryColor,
    this.size = 45.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: CommonColors.primaryColor,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: size,
              color: CommonColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
