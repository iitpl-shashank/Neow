import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';

class ForumPostCard extends StatefulWidget {
  final String? title;
  final String? description;
  final String? time;

  const ForumPostCard({
    super.key,
    this.title,
    this.description,
    this.time,
  });

  @override
  State<ForumPostCard> createState() => _ForumPostCardState();
}

class _ForumPostCardState extends State<ForumPostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDeviceWidth / 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    LocalImages.icLogo,
                  ),
                  radius: 21,
                ),
                kCommonSpaceH10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Neow',
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.time ?? '--',
                      style: getAppStyle(
                        color: CommonColors.mGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          CachedNetworkImage(
            imageUrl:
                "https://drive.google.com/uc?id=1TFXhApj4Vlcx5jtnnALRRrw9JWzhKHfl",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  LocalSvgs.icHeartIcon,
                  height: 18,
                  width: 18,
                ),
                SizedBox(width: 4),
                Text(
                  "56",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 16),
                Image.asset(LocalImages.icCommentIcon),
                SvgPicture.asset(
                  LocalSvgs.icCommentIcon,
                  height: 18,
                  width: 18,
                ),
                SizedBox(width: 4),
                Text("12"),
                Spacer(),
                Icon(Icons.share),
                SizedBox(width: 8),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8, right: 8),
          //   child: Text(
          //     widget.title ?? '--',
          //     textAlign: TextAlign.start,
          //     style: getAppStyle(
          //       color: CommonColors.blackColor,
          //       fontSize: 18,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          //   child: Text(
          //     widget.description ?? '--',
          //     maxLines: 3,
          //     overflow: TextOverflow.ellipsis,
          //     style: getAppStyle(
          //       color: CommonColors.mGrey,
          //       fontSize: 13,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
