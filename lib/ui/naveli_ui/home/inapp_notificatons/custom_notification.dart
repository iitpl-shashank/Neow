import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/primary_button.dart';

import '../../../../utils/common_colors.dart';

class CustomNotification extends StatelessWidget {
  final String imagePath;
  final String? imageText;
  final String subtitleText;
  final VoidCallback? onClose;
  final double? height;
  final double? width;
  final String? prepareText;
  final bool isLeftShift;
  final String? purpleLabel;
  final VoidCallback? purpleOnPress;
  final String? whiteLabel;
  final VoidCallback? whiteOnPress;

  const CustomNotification({
    super.key,
    required this.imagePath,
    this.imageText,
    required this.subtitleText,
    this.onClose,
    this.height,
    this.width,
    this.prepareText,
    this.isLeftShift = false,
    this.purpleLabel,
    this.purpleOnPress,
    this.whiteLabel,
    this.whiteOnPress,
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
                if (isLeftShift)
                  Transform.translate(
                    offset: const Offset(-25, 0),
                    child: Image.asset(
                      imagePath,
                      height: height ?? 170,
                      width: width ?? 170,
                    ),
                  ),
                if (!isLeftShift)
                  Image.asset(
                    imagePath,
                    height: height ?? 170,
                    width: width ?? 170,
                  ),
                if (imageText != null) const SizedBox(height: 20),
                if (imageText != null)
                  Text(
                    imageText ?? "",
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
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                if (prepareText != null) const SizedBox(height: 20),
                if (prepareText != null)
                  Text(
                    prepareText ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                if (purpleLabel != null) const SizedBox(height: 20),
                if (purpleLabel != null)
                  PrimaryButton(
                    label: purpleLabel,
                    height: 50,
                    width: 300,
                    onPress: purpleOnPress,
                  ),
                if (whiteLabel != null) const SizedBox(height: 20),
                if (whiteLabel != null)
                  PrimaryButton(
                    buttonColor: CommonColors.mWhite,
                    labelColor: CommonColors.purple,
                    borderColor: CommonColors.purple,
                    label: whiteLabel,
                    height: 50,
                    width: 300,
                    onPress: whiteOnPress,
                  ),
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
