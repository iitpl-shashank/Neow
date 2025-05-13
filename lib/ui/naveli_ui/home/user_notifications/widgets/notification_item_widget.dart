import 'package:flutter/material.dart';

import '../../../../../utils/common_colors.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem item;

  const NotificationItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: CommonColors.blueShade,
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: Colors.purple, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(
                          item.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: CommonColors.greyText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: CommonColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child:
              Divider(height: 1, thickness: 0.6, color: Colors.grey.shade300),
        ),
      ],
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String date;
  final String subtitle;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.date,
    required this.subtitle,
  });
}
