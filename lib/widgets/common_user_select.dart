import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonUserSelect extends StatefulWidget {
  final String imagePath;
  final String text;
  final String descriptionText;
  final void Function() onTap;
  final bool isSelected;

  const CommonUserSelect({
    super.key,
    required this.imagePath,
    required this.text,
    required this.descriptionText,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<CommonUserSelect> createState() => _CommonUserSelectState();
}

class _CommonUserSelectState extends State<CommonUserSelect> {
  bool _isExpanded = false, isTextVisible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isSelected == false) {
      setState(() {
        _isExpanded = false;
        isTextVisible = false;
      });
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              isTextVisible = !isTextVisible;
            });
          });
        });
        if (!widget.isSelected) {
          widget.onTap();
        }
      },
      child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 15,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: CommonColors.mWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 2,
                color: widget.isSelected
                    ? CommonColors.primaryColor
                    : CommonColors.mGrey300,
              ),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
            /* border: Border.all(
                        width: 2,
                        color: widget.isSelected
                            ? CommonColors.primaryColor
                            : CommonColors.mGrey,
                      ), */
          ),
          child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.text}',
                            style: TextStyle(
                              fontSize: 20,
                              color: CommonColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('${widget.descriptionText}')
                      ]),
                )

                /* Align(
                        alignment: Alignment.center,
                        child: 
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: 
                      ), */
              ]))),

      /* AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _isExpanded ? kDeviceWidth - 30 : 130,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: CommonColors.mWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        widget.isSelected ? const BoxShadow(
                          color: CommonColors.primaryColor,
                          blurRadius: 20.0,
                        ) : const BoxShadow(
                          color: CommonColors.mTransparent,
                          blurRadius: 20.0,
                        )
                      ],
                      image: DecorationImage(
                          image: AssetImage(widget.imagePath)),
                      border: Border.all(
                        width: 2,
                        color: widget.isSelected
                            ? CommonColors.primaryColor
                            : CommonColors.darkPrimaryColor,
                      ),
                    ),
                  ),
                  // ImageContainer(
                  //   image: widget.imagePath,
                  //   width: 100,
                  //   height: 100,
                  //   isCircle: true,
                  //   isBorder: true,
                  //   borderColor: widget.isSelected
                  //       ? CommonColors.primaryColor
                  //       : CommonColors.darkPrimaryColor,
                  //   // borderColor: CommonColors.darkPrimaryColor,
                  //   borderWidth: 2,
                  // ),
                  kCommonSpaceV10,
                  Text(
                    widget.text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: widget.isSelected
                          ? CommonColors.primaryColor
                          : CommonColors.darkPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (_isExpanded) ...[
              Flexible(
                child: Padding(
                  padding: kCommonScreenPadding10,
                  child: AnimatedOpacity(
                    opacity: isTextVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.descriptionText,
                      maxLines: 5,
                      style: const TextStyle(overflow: TextOverflow.ellipsis,color: CommonColors.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ), */
    );
  }
}
