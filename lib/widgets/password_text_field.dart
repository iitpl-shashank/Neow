import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonPasswordField extends StatefulWidget {
  final TextInputType? inputType;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const CommonPasswordField({
    this.inputType,
    this.hintText,
    this.controller,
    this.textInputAction,
    super.key,
  });

  @override
  State<CommonPasswordField> createState() => _CommonPasswordFieldState();
}

class _CommonPasswordFieldState extends State<CommonPasswordField> {
  bool isPassVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textInputAction: widget.textInputAction,
        keyboardType: widget.inputType,
        controller: widget.controller,
        cursorColor: CommonColors.primaryColor,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isPassVisible = !isPassVisible;
              });
            },
            child: Icon(
              isPassVisible ? Icons.visibility_off : Icons.visibility,
              color: CommonColors.mGrey,
            ),
          ),
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
          hintText: widget.hintText,
          hintStyle: getAppStyle(
              color: CommonColors.mGrey,
              fontSize: 13,
              fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
        autocorrect: false,
        obscureText: isPassVisible,
      ),
    );
  }
}
