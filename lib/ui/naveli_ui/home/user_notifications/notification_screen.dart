import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';
import 'viewModel/notification_view_model.dart';
import 'widgets/notification_item_widget.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // final List<NotificationItem> notifications = [
  //   NotificationItem(
  //     icon: Icons.bubble_chart_outlined,
  //     title: "Symptoms",
  //     date: "21/01",
  //     subtitle: "Track your period symptoms here at any time.",
  //   ),
  //   NotificationItem(
  //     icon: Icons.medication_outlined,
  //     title: "Medication",
  //     date: "21/01",
  //     subtitle: "Track your period symptoms here at any time.",
  //   ),
  //   NotificationItem(
  //     icon: Icons.bubble_chart_outlined,
  //     title: "Cramps",
  //     date: "21/01",
  //     subtitle: "Track your period symptoms here at any time.",
  //   ),
  //   NotificationItem(
  //     icon: Icons.bubble_chart_outlined,
  //     title: "Late Period",
  //     date: "21/01",
  //     subtitle: "Track your period symptoms here at any time.",
  //   ),
  // ];
  late NotificationViewModel notificationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController =
        Provider.of<NotificationViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationController.fetchNotifications(context: context);
    });
  }

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
        body: Consumer<NotificationViewModel>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.notifications.isEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.isNotEmpty
                      ? controller.errorMessage
                      : S.of(context)!.noNotificationYet,
                ),
              );
            }
            return ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final item = controller.notifications[index];
                return NotificationItemWidget(
                  item: NotificationItem(
                    key: item.name ?? "",
                    icon: Icons.notifications,
                    title: item.title ?? '',
                    date: formatDate(item.time?.toString() ?? ''),
                    subtitle: item.message ?? '',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
