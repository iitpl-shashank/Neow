import 'package:flutter/material.dart';

import '../../../../utils/common_colors.dart';

class CustomNotification extends StatelessWidget {
  final String imagePath;
  final String titleText;
  final String subtitleText;
  final VoidCallback? onClose;
  final bool showImageText;

  const CustomNotification({
    super.key,
    required this.imagePath,
    required this.titleText,
    required this.subtitleText,
    this.onClose,
    this.showImageText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                ),
                if (showImageText) const SizedBox(height: 20),
                if (showImageText)
                  Text(
                    titleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CommonColors.textPurple,
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  subtitleText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Close Button
          Positioned(
            right: 20,
            top: 20,
            child: GestureDetector(
              onTap: onClose ?? () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
