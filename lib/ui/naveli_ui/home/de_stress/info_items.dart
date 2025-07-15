import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

class InfoItems extends StatelessWidget {
  InfoItems(
      {super.key,
      this.imageUrl,
      required this.points,
      required this.title,
      required this.titleIcon});
  String? imageUrl;
  List<String>? points;
  String title;
  String titleIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                titleIcon,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          if (imageUrl != null) ...[
            SizedBox(height: 40),
            SizedBox(
              height: 308,
              width: 308,
              child: Image.asset(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40),
          ],
          if (points != null && points!.isNotEmpty) ...[
            SizedBox(height: 16),
            ...points!.asMap().entries.map((entry) {
              int index = entry.key;
              String point = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      child: Text(
                        "${index + 1}.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          SizedBox(height: 40),
          Divider(
            color: CommonColors.divider,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
