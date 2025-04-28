import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonMoreWidgets extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String buttonTitle;
  final String hintText;
  final VoidCallback? onPressed;
  final List<Map<String, dynamic>> listTexts;
  final int? itemCount;
  final TextEditingController? controller;

  const CommonMoreWidgets({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPressed,
    required this.buttonTitle,
    required this.controller,
    required this.hintText,
    required this.listTexts,
    this.itemCount,
  });

  @override
  State<CommonMoreWidgets> createState() => _CommonMoreWidgetsState();
}

class _CommonMoreWidgetsState extends State<CommonMoreWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kCommonSpaceV20,
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: widget.onPressed,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.buttonTitle,
                  style: const TextStyle(
                    color: Color(0xFF2C7E05),
                    fontSize: 14,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            final item = widget.listTexts[index];
            final text = item.keys.first;
            final isChecked = item.values.first;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CommonColors.primaryLite),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.circle_rounded,
                        size: 10,
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    kCommonSpaceH5,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          item.values.last,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.listTexts[index][text] = !isChecked;
                        });
                      },
                      child: Icon(
                        isChecked
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 25,
                        color: isChecked
                            ? CommonColors.primaryColor
                            : CommonColors.mGrey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // ListView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   padding: EdgeInsets.zero,
        //   itemCount: widget.itemCount ?? widget.listTexts.length,
        //   itemBuilder: (context, index) {
        //
        //
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 4.0),
        //       child: Container(
        //         padding: EdgeInsets.only(left: 5, right: 5, top: 3),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           color: CommonColors.primaryLite,
        //         ),
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(top: 5),
        //               child: Icon(
        //                 isChecked
        //                     ? Icons.check_circle
        //                     : Icons.radio_button_unchecked,
        //                 size: 20,
        //                 color: isChecked
        //                     ? CommonColors.primaryColor
        //                     : CommonColors.blackColor,
        //               ),
        //             ),
        //             kCommonSpaceH5,
        //             Expanded(
        //               child: Padding(
        //                 padding: const EdgeInsets.only(bottom: 5),
        //                 child: Text(
        //                   text,
        //                   textAlign: TextAlign.start,
        //                   style: TextStyle(
        //                     color: isChecked
        //                         ? CommonColors.primaryColor
        //                         : CommonColors.blackColor,
        //                     fontSize: 16,
        //                     fontWeight: FontWeight.w400,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             GestureDetector(
        //               onTap: () {
        //                 setState(() {
        //                   widget.listTexts[index][text] = !isChecked;
        //                 });
        //               },
        //               child: Icon(
        //                 isChecked
        //                     ? Icons.check_box_rounded
        //                     : Icons.check_box_outline_blank_rounded,
        //                 size: 25,
        //                 color: isChecked
        //                     ? CommonColors.primaryColor
        //                     : CommonColors.mGrey,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        Row(
          children: [
            Container(
              width: kDeviceWidth / 1.8,
              height: 40,
              decoration: ShapeDecoration(
                color: CommonColors.primaryLite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
