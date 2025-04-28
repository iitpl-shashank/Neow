import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/common_utils.dart';
import '../utils/local_images.dart';

class ProfileImageRound extends StatelessWidget {
  final double? size;
  final String? image;

  const ProfileImageRound({this.size, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        border: Border.all(
          color: CommonColors.mGrey,
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FadeInImage(
          placeholder: const AssetImage(
            LocalImages.icImageError,
          ),
          placeholderFit: BoxFit.cover,
          image: getImageProvider(imagePath: image ?? LocalImages.icImageError),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              LocalImages.icImageError,
              fit: BoxFit.cover,
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final Color? borderColor;
  final double borderWidth;
  final bool isBorder;
  final bool isCircle;

  const ImageContainer({
    this.height,
    this.width,
    this.image,
    this.borderWidth = 0.5,
    this.borderColor,
    this.isBorder = false,
    this.isCircle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(5);
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: isCircle ? null : borderRadius,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        border: isBorder
            ? Border.all(
                color: borderColor ?? CommonColors.mGrey,
                width: borderWidth,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: FadeInImage(
          placeholder: const AssetImage(
            LocalImages.icImageError,
          ),
          placeholderFit: BoxFit.contain,
          image: getImageProvider(imagePath: image),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              LocalImages.icImageError,
            );
          },
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  ImageProvider getImageProvider({String? imagePath}) {
    if (imagePath!.startsWith("http")) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith("assets")) {
      return AssetImage(imagePath);
    } else {
      return FileImage(File(imagePath));
    }
  }
}
