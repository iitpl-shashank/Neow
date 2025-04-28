import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common_colors.dart';
import 'global_variables.dart';

const SizedBox kCommonSpaceV15 = SizedBox(height: 15);
const SizedBox kCommonSpaceV20 = SizedBox(height: 20);
const SizedBox kCommonSpaceV30 = SizedBox(height: 30);
const SizedBox kCommonSpaceH15 = SizedBox(width: 15);
const SizedBox kCommonSpaceV5 = SizedBox(height: 5);
const SizedBox kCommonSpaceV3 = SizedBox(height: 3);
const SizedBox kCommonSpaceH5 = SizedBox(width: 5);
const SizedBox kCommonSpaceH3 = SizedBox(width: 3);
const SizedBox kCommonSpaceV10 = SizedBox(height: 10);
const SizedBox kCommonSpaceV8 = SizedBox(height: 8);
const SizedBox kCommonSpaceV50 = SizedBox(height: 50);
const SizedBox kCommonSpaceH10 = SizedBox(width: 10);
const EdgeInsets kCommonScreenPadding = EdgeInsets.all(15);
const EdgeInsets kCommonScreenPaddingH = EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets kCommonScreenPaddingV = EdgeInsets.symmetric(vertical: 15);
const EdgeInsets kCommonScreenPadding10 = EdgeInsets.all(10);
const EdgeInsets kCommonScreenPadding5 = EdgeInsets.all(5);
ShapeBorder kCommonShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
double kDeviceWidth = MediaQuery.of(mainNavKey.currentContext!).size.width;
double kDeviceHeight = MediaQuery.of(mainNavKey.currentContext!).size.height;
final kSmallCircular = Transform.scale(
  scale: 0.7,
  child: const CircularProgressIndicator(
    strokeWidth: 2,
    color: CommonColors.mWhite,
  ),
);

EdgeInsets kCommonAllBottomPadding = EdgeInsets.fromLTRB(
  15,
  15,
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.bottom +
      (Platform.isIOS ? 10 : 15),
);

EdgeInsets kCommonAllTopPadding = EdgeInsets.fromLTRB(
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.top + 15,
  15,
  15,
);

EdgeInsets kCommonAllTopBottomPadding = EdgeInsets.fromLTRB(
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.top + 15,
  15,
  MediaQuery.of(mainNavKey.currentContext!).viewPadding.bottom + 10,
);

// var networkImageLoadBuilder =
//     (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//   if (loadingProgress == null) return child;
//   return Center(
//     child: CircularProgressIndicator(
//       strokeWidth: 2,
//       value: loadingProgress.expectedTotalBytes != null
//           ? loadingProgress.cumulativeBytesLoaded /
//               loadingProgress.expectedTotalBytes!
//           : null,
//     ),
//   );
// };
//
// var networkImageLoadBuilderWhite =
//     (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//   if (loadingProgress == null) return child;
//   return Center(
//     child: CircularProgressIndicator(
//       strokeWidth: 2,
//       color: Colors.white,
//       value: loadingProgress.expectedTotalBytes != null
//           ? loadingProgress.cumulativeBytesLoaded /
//               loadingProgress.expectedTotalBytes!
//           : null,
//     ),
//   );
// };
//
// var networkImageErrorBuilder = (
//     context,
//     exception,
//     stackTrac,
//     ) {
//   return Image.asset(
//     LocalImages.ic_image_error,
//     fit: BoxFit.cover,
//   );
// };
//
// var networkGridImageErrorBuilder = (
//     context,
//     exception,
//     stackTrac,
//     ) {
//   return Image.asset(
//     LocalImages.ic_image_error,
//     fit: BoxFit.cover,
//     height: 250,
//   );
// };

TextStyle getAppStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
  Color? textDecorationColor,
  TextDecorationStyle? textDecorationStyle,
}) {
  return TextStyle(
    fontFamily: AppConstants.OUTFIT_FONT,
    color: color ?? Colors.black87,
    letterSpacing: letterSpacing ?? 0.3,
    decoration: decoration,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decorationColor: textDecorationColor,
    decorationStyle: textDecorationStyle,
  );
}

TextStyle getGoogleFontStyle({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextDecoration? decoration,
  double? height,
  double? letterSpacing,
  Color? textDecorationColor,
  TextDecorationStyle? textDecorationStyle,
}) {
  return GoogleFonts.piedra(
    color: color ?? Colors.black87,
    decoration: decoration,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    height: height,
    decorationColor: textDecorationColor,
    decorationStyle: textDecorationStyle,
  );
}

class AppConstants {
  /* ------------------- Language Codes ------------------- */
  static const String LANGUAGE_ENGLISH = 'en';
  static const String LANGUAGE_HINDI = 'hi';
  // static const String LANGUAGE_MARATHI = 'mr';

  /* ------------------- font families ------------------- */

  static const String OUTFIT_FONT = 'Outfit';

  /* ------------------- Login roles ------------------- */

  static const String NEOWME = "2";
  static const String BUDDY = "3";
  static const String CYCLE_EXPLORER = "4";
}
