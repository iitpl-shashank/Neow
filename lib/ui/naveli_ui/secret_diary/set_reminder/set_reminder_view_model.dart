import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../models/common_master.dart';
import '../../../../models/monthly_reminder_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class SetReminderViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<MonthlyReminderData> monthlyReminderDataList = [];
  List<MonthlyReminderData> currentMonthReminders = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> storeMonthlyReminderApi({
    required String? reminderDate,
    required String? reminderMonth,
    required String? reminderType,
    required String? reminderFor,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.reminder_date: reminderDate,
      ApiParams.reminder_month: reminderMonth,
      ApiParams.reminder_type: reminderType,
      ApiParams.reminder_for: reminderFor,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeMonthlyReminder(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................set reminder oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      getMonthlyReminderDataApi();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      // Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future<void> getMonthlyReminderDataApi() async {
    CommonUtils.showProgressDialog();
    MonthlyReminderMaster? master =
        await _services.api!.getMonthlyReminderData();
    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................set reminder oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      monthlyReminderDataList = master.data ?? [];

      // Filter reminders for the current month
      DateTime now = DateTime.now();
      String currentMonth = DateFormat('MMMM').format(now);
      currentMonthReminders = monthlyReminderDataList
          .where((reminder) => reminder.reminderMonth == currentMonth)
          .toList();

      // Format and print reminders
      String remindersString = '';
      for (var reminder in currentMonthReminders) {
        String formattedDate = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(reminder.reminderDate!));
        remindersString +=
            '$formattedDate ${reminder.reminderType} ${reminder.reminderFor}\n';
      }
      print(
          remindersString); // You can store or display this string as required

      // Show success message or any other logic here
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}
