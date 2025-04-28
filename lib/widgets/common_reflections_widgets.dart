import 'package:flutter/material.dart';

import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonReflectionsWidgets extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int? itemCount;
  final List<String> listTexts;

  const CommonReflectionsWidgets(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.itemCount,
      required this.listTexts});

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
                  image: AssetImage(imageUrl),
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // shadows: [
                //   BoxShadow(
                //     color: Color(0x3F000000),
                //     blurRadius: 4,
                //     offset: Offset(0, 4),
                //     spreadRadius: 0,
                //   )
                // ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        kCommonSpaceV10,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 5, right: 5),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(
                    Icons.circle_rounded,
                    size: 10,
                    color: CommonColors.black54,
                  ),
                ),
                kCommonSpaceH5,
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      listTexts[index],
                      style: const TextStyle(
                          color: CommonColors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
