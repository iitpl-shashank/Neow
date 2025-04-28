import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonInterestOption extends StatefulWidget {
  final String title;
  final bool isMainTitle;
  final bool isOption;
  final bool isFavouriteSelected;
  // final bool isNotInterestedSelected;
  final Function(String title, bool isSelected)? onFavouriteSelectionChanged;
  // final Function(String title, bool isSelected)?
  //     onNotInterestedSelectionChanged;

  const CommonInterestOption({
    super.key,
    required this.title,
    this.isMainTitle = false,
    this.isOption = true,
    this.onFavouriteSelectionChanged,
    // this.onNotInterestedSelectionChanged,
    required this.isFavouriteSelected,
    // required this.isNotInterestedSelected,
  });

  @override
  _CommonInterestOptionState createState() => _CommonInterestOptionState();
}

class _CommonInterestOptionState extends State<CommonInterestOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kCommonSpaceV10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isMainTitle
                ? Text(
                    widget.title,
                    style: getGoogleFontStyle(fontSize: 30),
                  )
                : Text(
                    widget.title,
                    style: getAppStyle(
                      color: CommonColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            const Spacer(),
            if (widget.isOption) ...[
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: widget.isFavouriteSelected
                        ? CommonColors.darkPink
                        : CommonColors.mGrey200,
                    foregroundColor: widget.isFavouriteSelected
                        ? CommonColors.mWhite
                        : CommonColors.blackColor),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.favorite_outlined,
                  size: 25,
                ),
                onPressed: () {
                  widget.onFavouriteSelectionChanged
                      ?.call(widget.title, widget.isFavouriteSelected);
                },
              ),
              // IconButton(
              //   style: IconButton.styleFrom(
              //       backgroundColor: widget.isNotInterestedSelected
              //           ? CommonColors.darkPink
              //           : CommonColors.mGrey200,
              //       foregroundColor: widget.isNotInterestedSelected
              //           ? CommonColors.mWhite
              //           : CommonColors.blackColor),
              //   padding: EdgeInsets.zero,
              //   icon: Icon(
              //     Icons.not_interested_outlined,
              //     size: 25,
              //   ),
              //   onPressed: () {
              //     widget.onNotInterestedSelectionChanged
              //         ?.call(widget.title, widget.isNotInterestedSelected);
              //   },
              // ),
            ]
          ],
        ),
        kCommonSpaceV5,
        widget.isOption
            ? Container(
                height: 1,
                color: CommonColors.mGrey300,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
