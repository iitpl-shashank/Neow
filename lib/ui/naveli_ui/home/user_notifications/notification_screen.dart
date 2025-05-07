import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../../../../generated/i18n.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context)!.notifications,
        ),
        backgroundColor: CommonColors.bgColor,
      ),
      body: Center(
        child: Text(
          S.of(context)!.noNotificationYet,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    ));
  }
}
