import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';

class CommonRoundedContainer extends StatelessWidget {
  final String text;
  final String image;
  final GestureTapCallback? onTap;

  const CommonRoundedContainer(
      {super.key, required this.text, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF9E72C3),
                        // Color(0xFFCCB3E9),
                        // Color(0xFFD6C2EB),
                        // Color(0xFFDCC9ED),
                        Color(0xFF7338A0),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 1, color: CommonColors.primaryColor)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(image),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: getAppStyle(
                  color: Colors.black,
                  fontSize: 15,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
