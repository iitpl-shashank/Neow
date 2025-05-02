import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/local_images.dart';

class HealthmixCategoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final Color backgroundColor;
  final VoidCallback onTap;

  const HealthmixCategoryCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: imagePath != ""
                  ? Image.network(
                      width: MediaQuery.of(context).size.width / 2.2,
                      imagePath ?? "",
                      height: 100,
                      fit: BoxFit.cover,
                      
                    )
                  : Image.asset(
                      LocalImages.img_nutrition,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
