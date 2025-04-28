import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../database/app_preferences.dart';
import '../../../models/monthly_reminder_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class MonthlyRemindersViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<String> remindersList = [];
  DateTime currentDateTime = DateTime.now();
  List<Appointment> meetingList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getMonthlyRemindersList() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.start_date: "11-Dec-2025",
      ApiParams.end_date: "20-Dec-2025",
    };
    MonthlyReminderMaster? master = await _services.api!.getMonthlyRemindersList(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print("................................secret diary oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      for(int i=0; i<master.data!.length;i++){

        String combinedDateTime = "${master.data![i].reminderDate??""} ${master.data![i].reminderTime??""}";

        print("combine Date:${combinedDateTime}");
        // Define the format of the input date and time
        DateFormat inputFormat = DateFormat("dd-MMM-yyyy hh:mm a");

        // Parse the combined string into a DateTime object
        DateTime parsedDateTime = inputFormat.parse(combinedDateTime);

        var meetingStart = DateTime(
          parsedDateTime.year,
          parsedDateTime.month,
          parsedDateTime.day,
          parsedDateTime.hour,
          parsedDateTime.minute,
        );
        print("parsedDateTime Date:${meetingStart}");

        var data = Appointment(
          startTime: meetingStart,
          endTime: meetingStart.add(const Duration(hours: 1)),
          subject: master.data![i].reminderFor??"",
        );

        if (meetingList.isEmpty) {
          print("list empty blue");
          data.color = Colors.blue;
        } else if (meetingList.length == 1) {
          print("list empty blue");
          data.color = Colors.red;
        } else if (meetingList.length % 2 == 0) {
          data.color = Colors.red;
          print("list red");
        } else {
          data.color = Colors.blue;
        }
        meetingList.add(data);
      }
      notifyListeners();
      print("daaa =>${meetingList}");
    }
    notifyListeners();
  }

  Future<void> addMonthlyReminder({required String date, required String time, required String title}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.reminder_date: date,
      ApiParams.reminder_time: time,
      ApiParams.reminder_for: title,
    };

    MonthlyReminderMaster? master = await _services.api!.addMonthlyReminder(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Add Monthtly reminders.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    }
    notifyListeners();
  }
}
