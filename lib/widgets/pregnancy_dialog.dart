import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/local_images.dart';

import '../generated/i18n.dart';

class PregnancyDialog extends StatelessWidget {
  const PregnancyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              LocalImages.pregnancy,
              width: 92,
              height: 92,
            ),
            SizedBox(height: 24),
            Text(
              S.of(context)!.welcomeToJourneyOfParent,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              S.of(context)!.comingSoon,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7A3E9D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  S.of(context)!.okay,
                  style: TextStyle(fontSize: 16, color: CommonColors.bgColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
