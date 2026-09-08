import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CustomTextFieldContainer extends StatelessWidget {
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final bool isReadOnly;
  final bool isLabelText;
  final bool isDropDown;
  final bool showEditIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onEditTap;
  final FocusNode? focusNode;
  final Color? color;
  final Color? textColor;
  final String? hintText;
  final String? labelText;
  final double? lblFontSize;
  final TextInputType? keyboardType;
  final dynamic border;
  final List<String>? dropDownItems;
  final Function(String)? onItemSelected;

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
    this.isDropDown = false,
    this.showEditIcon = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onEditTap,
    this.focusNode,
    this.dropDownItems,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    Widget? effectiveSuffix = suffixIcon;
    if (effectiveSuffix == null && showEditIcon) {
      effectiveSuffix = InkWell(
        onTap: onEditTap ?? onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(
            Icons.edit_outlined,
            size: 18,
            color: CommonColors.primaryColor,
          ),
        ),
      );
    }

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
              ? Row(
                  children: [
                    if (prefixIcon != null) prefixIcon!,
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller?.text.isNotEmpty == true
                              ? controller?.text
                              : null,
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
                              controller?.text = newValue;
                              if (onItemSelected != null) {
                                onItemSelected!(newValue);
                              }
                              (context as Element).markNeedsBuild();
                            }
                          },
                        ),
                      ),
                    ),
                    if (showEditIcon)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                  ],
                )
              : TextField(
                  onTap: onTap,
                  controller: controller,
                  focusNode: focusNode,
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
                    prefixIcon: prefixIcon,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    suffixIcon: effectiveSuffix,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    border: border == true
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
