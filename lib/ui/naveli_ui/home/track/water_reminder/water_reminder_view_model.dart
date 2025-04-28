import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../../../models/common_master.dart';
import '../../../../../models/water_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/local_images.dart';
import 'package:http/http.dart' as http;

class WaterReminderViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isSwitched = false;
  String dropdownValue = '30 min';
  double progress = 0.0;
  int waterMl = 0;
  int currentImageIndex = 0;
  List<String> images = [
    LocalImages.img_water_old,
    LocalImages.img_water_1,
    LocalImages.img_water_2,
    LocalImages.img_water_3,
    LocalImages.img_water_4,
    LocalImages.img_water_5,
    LocalImages.img_water_6,
    LocalImages.img_water_7,
    LocalImages.img_water_8,
    LocalImages.img_water_9,
    LocalImages.img_water_10,
  ];
  int incrementCount = 0;
  Timer? notificationTimer;
  List<dynamic> waterRemainderHistory = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  // Method to start or stop periodic notifications based on switch status
  void toggleNotifications(bool value) {
    isSwitched = value;
    notifyListeners();
    if (isSwitched) {
      _startNotificationTimer();
    } else {
      _cancelNotificationTimer();
    }
  }

  // Method to schedule periodic notifications
  void _startNotificationTimer() {
    int interval = _getIntervalInMinutes(dropdownValue);
    if (interval > 0) {
      notificationTimer = Timer.periodic(Duration(minutes: interval), (timer) {
        _showNotification();
      });
    }
  }

  // Method to cancel periodic notifications
  void _cancelNotificationTimer() {
    notificationTimer?.cancel();
  }

  // Method to show a notification
  void _showNotification() {

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Water Reminder',
        body: "It's time to drink water...",
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://c.ndtvimg.com/2022-11/089qdk1g_benefits-of-drinking-water-before-brushing_625x300_24_November_22.jpg', // Change this to your image path
      ),
    );

  }

  // Method to convert dropdown value to minutes
  int _getIntervalInMinutes(String dropdownValue) {
    switch (dropdownValue) {
      case '30 min':
        return 1;
      case '45 min':
        return 45;
      case '1 hour':
        return 60;
      case '90 min':
        return 90;
      case '2 hour':
        return 120;
      default:
        return 0;
    }
  }

  void showStoredGlass() {
    if (waterMl == 250) {
      incrementCount = 1;
      currentImageIndex = 1;
    } else if (waterMl == 500) {
      incrementCount = 2;
      currentImageIndex = 2;
    } else if (waterMl == 750) {
      incrementCount = 3;
      currentImageIndex = 3;
    } else if (waterMl == 1000) {
      incrementCount = 4;
      currentImageIndex = 4;
    } else if (waterMl == 1250) {
      incrementCount = 5;
      currentImageIndex = 5;
    } else if (waterMl == 1500) {
      incrementCount = 6;
      currentImageIndex = 6;
    } else if (waterMl == 1750) {
      incrementCount = 7;
      currentImageIndex = 7;
    } else if (waterMl == 2000) {
      incrementCount = 8;
      currentImageIndex = 8;
    } else if (waterMl == 2250) {
      incrementCount = 9;
      currentImageIndex = 9;
    } else if (waterMl == 2500) {
      incrementCount = 10;
      currentImageIndex = 10;
    }
    notifyListeners();
  }

  void increaseProgress() {
    if (incrementCount < 10) {
      // Check if incrementCount is less than 10
      incrementCount++;
      waterMl += 250;
      if (incrementCount <= 10) {
        currentImageIndex = (currentImageIndex + 1) % images.length;
      }
    }
    notifyListeners();
  }

  void setProgress(int val, int ml) {
    incrementCount = val;
    currentImageIndex = val;
    waterMl = ml;
    /* if (incrementCount > 0) {
      incrementCount--;
      waterMl -= 250;
      if (currentImageIndex > 0) {
        currentImageIndex--;
      }
    } */
    notifyListeners();
  }

  void decreaseProgress() {
    if (incrementCount > 0) {
      incrementCount--;
      waterMl -= 250;
      if (currentImageIndex > 0) {
        currentImageIndex--;
      }
    }
    notifyListeners();
  }

  Future<void> getWaterDetailApi() async {
    CommonUtils.showProgressDialog();
    WaterMaster? master = await _services.api!.getWaterDetail();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................water reminder oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      if (master.data?.waterMl != null) {
        waterMl = int.parse(master.data!.waterMl!);
      }
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeWaterDetailApi({
    required int waterMl,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.water_ml: waterMl,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeWaterDetail(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................water reminder oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        'Data submitted successfully',
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }

  Future<List> fetchWaterHistory() async {
    String numberString = "${globalUserMaster?.id}";
    print(globalUserMaster?.height);
    // CommonUtils.showProgressDialog();

    final url = Uri.parse(
        'https://neowindia.com/customeApi/water_reminder_history.php?user_id=' +
            numberString);

    // Create headers
    final headers = {
      'Content-Type': 'application/json',
    };

    // Send the request
    final response = await http.get(
      url,
    );

    // Handle the response
    print(url);
    print('==============================================================');
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      print('get Data successfully=====================================');
      //  responseBody.map((item) => weightHistory.add MonthData.fromJson(item));
      waterRemainderHistory = responseBody;
      print(response.body);
      return responseBody.toList();
    } else {
      print('Error=====================================');

      throw Exception('Failed to load data');
    }
    notifyListeners();
  }
}
