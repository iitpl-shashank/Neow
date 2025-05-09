// import 'package:flutter/material.dart';

// import '../utils/common_colors.dart';
// import '../utils/constant.dart';

// class CustomTextFieldContainer extends StatelessWidget {
//   final TextEditingController? controller;
//   final GestureTapCallback? onTap;
//   final bool isReadOnly;
//   final bool isLabelText;
//   final Color? color;
//   final Color? textColor;
//   final String? hintText;
//   final String? labelText;
//   final double? lblFontSize;
//   final TextInputType? keyboardType;
//   final dynamic border;

//   const CustomTextFieldContainer({
//     super.key,
//     this.controller,
//     this.isReadOnly = false,
//     this.hintText,
//     this.labelText,
//     this.isLabelText = true,
//     this.color,
//     this.keyboardType,
//     this.textColor,
//     this.lblFontSize,
//     this.onTap,
//     this.border,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         isLabelText
//             ? Text(
//                 labelText ?? '',
//                 style: getAppStyle(
//                   color: CommonColors.mGrey201,
//                   fontSize: lblFontSize ?? 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               )
//             : const SizedBox.shrink(),
//         Container(
//           height: 45,
//           padding: const EdgeInsets.only(left: 0, right: 8),
//           decoration: BoxDecoration(
//             color: color ?? CommonColors.primaryLite,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: TextField(
//             onTap: onTap,
//             controller: controller,
//             readOnly: isReadOnly,
//             keyboardType: keyboardType,
//             cursorColor: textColor ?? CommonColors.mWhite,
//             style: TextStyle(
//               color: textColor ?? CommonColors.blackColor,
//               fontSize: 15,
//             ),
//             decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.only(bottom: 5, top: 5),
//                 isDense: true,
//                 hintText: hintText,
//                 // border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 // enabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 border: border
//                     ? UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black))
//                     : InputBorder.none),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CustomTextFieldContainer extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final bool isReadOnly;
  final bool isLabelText;
  final bool isDropDown; // New parameter to enable dropdown
  final Color? color;
  final Color? textColor;
  final String? hintText;
  final String? labelText;
  final double? lblFontSize;
  final TextInputType? keyboardType;
  final dynamic border;
  final List<String>? dropDownItems; // Dropdown items
  final Function(String)?
      onItemSelected; // Callback for dropdown item selection

  const CustomTextFieldContainer({
    super.key,
    this.controller,
    this.isReadOnly = false,
    this.hintText,
    this.labelText,
    this.isLabelText = true,
    this.color,
    this.keyboardType,
    this.textColor,
    this.lblFontSize,
    this.onTap,
    this.border,
    this.isDropDown = false, // Default to false
    this.dropDownItems,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabelText
            ? Text(
                labelText ?? '',
                style: getAppStyle(
                  color: CommonColors.mGrey201,
                  fontSize: lblFontSize ?? 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox.shrink(),
        Container(
          height: 45,
          padding: const EdgeInsets.only(left: 0, right: 8),
          decoration: BoxDecoration(
            color: color ?? CommonColors.primaryLite,
            borderRadius: BorderRadius.circular(5),
          ),
          child: isDropDown
              ? DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller?.text.isNotEmpty == true
                        ? controller?.text
                        : null, // Bind to controller's text
                    hint: Text(
                      hintText ?? '',
                      style: TextStyle(
                        color: textColor ?? CommonColors.blackColor,
                        fontSize: 15,
                      ),
                    ),
                    isExpanded: true,
                    items: dropDownItems?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: textColor ?? CommonColors.blackColor,
                            fontSize: 15,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller?.text = newValue; // Update controller text
                        if (onItemSelected != null) {
                          onItemSelected!(newValue);
                        }
                        (context as Element).markNeedsBuild();
                      }
                    },
                  ),
                )
              : TextField(
                  onTap: onTap,
                  controller: controller,
                  readOnly: isReadOnly,
                  keyboardType: keyboardType,
                  cursorColor: textColor ?? CommonColors.mWhite,
                  style: TextStyle(
                    color: textColor ?? CommonColors.blackColor,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 5, top: 5),
                    isDense: true,
                    hintText: hintText,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: border
                        ? const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )
                        : InputBorder.none,
                  ),
                ),
        ),
      ],
    );
  }
}
