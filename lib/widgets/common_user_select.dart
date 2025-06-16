import 'package:flutter/material.dart';
import '../utils/common_colors.dart';

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
          left: 2,
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
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Row(
            children: [
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                height: 70,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.text}',
                        style: TextStyle(
                          fontSize: 18,
                          color: CommonColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.descriptionText}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
