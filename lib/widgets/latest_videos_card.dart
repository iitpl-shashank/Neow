import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';

class LatestVideoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String category;
  final String? timeDifference;
  final VoidCallback onTap;

  const LatestVideoCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.category,
    this.timeDifference,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 3, bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: CommonColors.mWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                kCommonSpaceH10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      kCommonSpaceV10,
                      Row(
                        children: [
                          Text(
                            category,
                            style: getAppStyle(
                              color: CommonColors.blackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          kCommonSpaceH10,
                          SizedBox(
                            height: 15,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: CommonColors.mGrey,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                ' ',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          kCommonSpaceH10,
                          Text(
                            timeDifference ?? '',
                            style: getAppStyle(
                              color: CommonColors.mGrey,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
