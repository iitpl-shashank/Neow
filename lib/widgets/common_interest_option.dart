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
        Padding(
          padding:  EdgeInsets.symmetric(horizontal:widget.isOption?20: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.isMainTitle
                  ? Text(
                      widget.title,
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      widget.title,
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              const Spacer(),
              if (widget.isOption) ...[
                IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: widget.isFavouriteSelected
                          ? CommonColors.mGrey200
                          : CommonColors.mGrey200,
                      foregroundColor: widget.isFavouriteSelected
                          ? CommonColors.darkPink
                          : CommonColors.mWhite),
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
        ),
        kCommonSpaceV5,
        widget.isOption
            ? Padding(
          padding:  EdgeInsets.symmetric(horizontal:widget.isOption?20: 10.0,),
              child: Container(
                  height: 1,
                  color: CommonColors.mGrey300,
                ),
            )
            : const SizedBox.shrink()
      ],
    );
  }
}
