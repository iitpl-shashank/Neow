import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../../../../generated/i18n.dart';
import 'widgets/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.bubble_chart_outlined,
      title: "Symptoms",
      date: "21/01",
      subtitle: "Track your period symptoms here at any time.",
    ),
    NotificationItem(
      icon: Icons.medication_outlined,
      title: "Medication",
      date: "21/01",
      subtitle: "Track your period symptoms here at any time.",
    ),
    NotificationItem(
      icon: Icons.bubble_chart_outlined,
      title: "Cramps",
      date: "21/01",
      subtitle: "Track your period symptoms here at any time.",
    ),
    NotificationItem(
      icon: Icons.bubble_chart_outlined,
      title: "Late Period",
      date: "21/01",
      subtitle: "Track your period symptoms here at any time.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.mWhite,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              S.of(context)!.notifications,
            ),
          ),
          backgroundColor: CommonColors.bgGrey,
          leading: SizedBox.shrink(),
          centerTitle: true,
          elevation: 3,
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItemWidget(item: notifications[index]);
          },
        ),
      ),
    );
  }
}
