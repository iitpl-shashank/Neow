import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'common_colors.dart';

class CommonSecretDiaryContainer extends StatelessWidget {
  final String? imagePath;
  final String? defaultImage;
  final String title;

  const CommonSecretDiaryContainer({super.key, this.imagePath, required this.title, this.defaultImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: ShapeDecoration(
            // color: CommonColors.primaryColor.withOpacity(0.5),
            color: const Color(0xFFFAF7F9),
            image: DecorationImage(image: AssetImage(imagePath ?? defaultImage ?? ''), fit: BoxFit.contain),
            shape: const OvalBorder(
              side: BorderSide(width: 1, color: CommonColors.mWhite),
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
        kCommonSpaceV5,
        Text(
          title,
          style: const TextStyle(
            color: CommonColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
