import 'package:flutter/material.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItem item;

  const NotificationItemWidget({
    super.key,
    required this.item,
  });

  void _handleTap(BuildContext context) {
    if (item.title == "Time to Check In With Your Body!") {
      // Do something specific
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Clicked: ${item.title}")),
      );
    } else if (item.title == "We’ve Got Something New for You!") {
      // Another action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("New for you!")),
      );
    } else {
      // Default action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification tapped")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
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
                  child: Icon(
                    item.icon,
                    color: isToday(item.date)
                        ? CommonColors.purple
                        : CommonColors.purple.withAlpha(102),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isToday(item.date)
                                  ? CommonColors.blackColor
                                  : CommonColors.blackColor.withAlpha(102),
                            ),
                          ),
                          Text(
                            item.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: isToday(item.date)
                                  ? CommonColors.greyText
                                  : CommonColors.greyText.withAlpha(102),
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
                          color: isToday(item.date)
                              ? CommonColors.greyText
                              : CommonColors.greyText.withAlpha(102),
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
            child: Divider(
              height: 1,
              thickness: 0.6,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
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
