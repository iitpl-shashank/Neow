import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onEditComplete;
  final double? height;

  const CommonTextField({
    this.controller,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.isRequired = false,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged: onEditComplete,
        textInputAction: textInputAction,
        keyboardType: inputType,
        controller: controller,
        cursorColor: CommonColors.primaryColor,
        enabled: enabled ?? true,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this field';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hintText,
          hintStyle: getAppStyle(
              color: CommonColors.mGrey,
              fontSize: 13,
              fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 200,
        autocorrect: false,
      ),
    );
  }
}

class PrefixTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const PrefixTextField({
    required this.controller,
    required this.prefix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          prefix,
          Flexible(
            child: TextFormField(
              onChanged: onEditComplete,
              textInputAction: textInputAction,
              keyboardType: inputType,
              controller: controller,
              cursorColor: CommonColors.primaryColor,
              enabled: enabled ?? true,
              decoration: InputDecoration(
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                prefixIconColor: Colors.black,
                hintText: hintText,
                hintStyle: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 200,
              autocorrect: false,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const OTPTextField({
    required this.controller,
    required this.prefix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          prefix,
          Flexible(
            child: TextFormField(
              onChanged: onEditComplete,
              textInputAction: textInputAction,
              keyboardType: inputType,
              controller: controller,
              cursorColor: CommonColors.primaryColor,
              enabled: enabled ?? true,
              decoration: InputDecoration(
                counterText: "",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                prefixIconColor: Colors.black,
                hintText: hintText,
                hintStyle: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 200,
              autocorrect: false,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuffixTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget suffix;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onEditComplete;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const SuffixTextField({
    required this.controller,
    required this.suffix,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.onTap,
    this.margin,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        margin: margin ?? const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                onChanged: onEditComplete,
                textInputAction: textInputAction,
                keyboardType: inputType,
                controller: controller,
                cursorColor: CommonColors.primaryColor,
                enabled: enabled ?? true,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  prefixIconColor: Colors.black,
                  hintText: hintText,
                  hintStyle: getAppStyle(
                      color: CommonColors.mGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                ),
                maxLines: maxLines ?? 1,
                maxLength: maxLength ?? 200,
                autocorrect: false,
                style: getAppStyle(
                  color: CommonColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            suffix
          ],
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool isRequired;
  final bool? enabled;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final void Function(String)? onEditComplete;
  final double? height;
  final bool? isObscure;

  const LabeledTextField({
    this.controller,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.isRequired = false,
    this.enabled,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.isObscure,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: CommonColors.primaryColor),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffcfbee4),
            blurRadius: 5,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(top: 5, left: 15.0),
      child: TextFormField(
        obscureText: isObscure ?? false,
        onChanged: onEditComplete,
        textInputAction: textInputAction,
        keyboardType: inputType,
        controller: controller,
        readOnly: readOnly ?? false,
        cursorColor: CommonColors.primaryColor,
        enabled: enabled ?? true,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this field';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          //   borderSide: const BorderSide(color: Colors.transparent),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          //   borderSide: const BorderSide(color: Colors.transparent),
          // ),
          label: Text(hintText!),
          labelStyle: getAppStyle(
              color: CommonColors.mGrey,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          hintText: hintText,
          hintStyle: getAppStyle(
              color: CommonColors.mGrey,
              fontSize: 15,
              fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
        style: TextStyle(
            color: CommonColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.w500),
        maxLines: maxLines ?? 1,
        maxLength: maxLength ?? 200,
        autocorrect: false,
      ),
    );
  }
}

class LabelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final bool isRequired;
  final bool isOnlyChar;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onEditComplete;
  final double? height;
  final void Function()? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Color? bgColor;

  const LabelTextField({
    this.controller,
    this.hintText,
    this.inputType,
    this.maxLines,
    this.maxLength,
    this.enabled,
    this.isRequired = false,
    this.isOnlyChar = false,
    this.textInputAction,
    this.onEditComplete,
    this.height,
    this.label,
    this.onTap,
    this.readOnly,
    this.suffixIcon,
    this.bgColor,
    this.textCapitalization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Flexible(
                child: Text(
                  label!,
                  maxLines: 2,
                  style: getAppStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: CommonColors.blackColor,
                  ),
                ),
              ),
              if (isRequired) ...[
                kCommonSpaceH5,
                Text(
                  "*",
                  style: getAppStyle(
                    color: CommonColors.mRed,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            ],
          ),
          kCommonSpaceV5,
        ],
        Container(
          height: maxLines != null ? 100 : 50,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
            color: bgColor ?? CommonColors.mWhite,
            border: Border.all(color: CommonColors.primaryColor),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: TextFormField(
            readOnly: readOnly ?? false,
            onTap: onTap,
            onChanged: onEditComplete,
            textInputAction: textInputAction,
            keyboardType: inputType,
            controller: controller,
            cursorColor: CommonColors.primaryColor,
            enabled: enabled ?? true,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            inputFormatters: isOnlyChar
                ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]
                : null,
            // Only allow alphabets
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 8, left: 15, right: 15),
              counterText: "",
              hintText: hintText ?? "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxLines ?? 1,
            maxLength: maxLength ?? 200,
            autocorrect: false,
            style: getAppStyle(
              color: CommonColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
