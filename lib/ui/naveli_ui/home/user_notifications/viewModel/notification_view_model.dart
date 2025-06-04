import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/user_notifications/model/notification_list_model.dart';
import 'package:naveli_2023/services/api_services.dart';
import '../../../../../generated/i18n.dart';

class NotificationViewModel with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  List<NotificationData> notifications = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchNotifications(
      {required String lang, required BuildContext context}) async {
    try {
      isLoading = true;
      errorMessage = '';
      notifyListeners();

      NotificationListModel? result =
          await _apiServices.getUserNotificationsList(lang: lang);
      if (result != null && result.data != null) {
        log("Fetched notifications: ${result}");
        notifications = result.data!;
      } else {
        notifications = [];
        errorMessage = S.of(context)!.noNotificationYet;
      }
    } catch (e) {
      notifications = [];
      errorMessage = S.of(context)!.failedToGetNotifications;
      debugPrint('NotificationController error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
