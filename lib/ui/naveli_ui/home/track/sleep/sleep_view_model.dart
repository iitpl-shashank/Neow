import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../../../models/common_master.dart';
import '../../../../../models/sleep_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import 'package:http/http.dart' as http;

import '../../../../../services/api_url.dart';

class SleepViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  SleepData? sleepData;
  List<dynamic> sleeptHistory = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getSleepDetailApi() async {
    CommonUtils.showProgressDialog();
    SleepMaster? master = await _services.api!.getSleepDetails();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................sleep oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      sleepData = master.data;
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeSleepDetailApi({
    required String bedTime,
    required String wakeUpTime,
    required String sleepTime,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.bad_time: bedTime,
      ApiParams.wake_up_time: wakeUpTime,
      ApiParams.total_sleep_time: sleepTime,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeSleepDetail(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................sleep oops.............................");
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

  Future<void> storeWeightHistory({
    required String weight,
    required String weightType,
  }) async {
    String numberString = "${globalUserMaster?.id}";
    // CommonUtils.showProgressDialog();

    final url = Uri.parse(ApiUrl.SLEEP_HISTORY_PHP);

    // Create headers
    final Map<String, String> data = {
      'user_id': numberString,
      'weight': weight,
      'weight_type': weightType,
    };

    // Send the request
    final response = await http.post(
      url,
      body: data,
    );
    CommonUtils.hideProgressDialog();
    // Handle the response
    if (response.statusCode == 200) {
      print('Data submitted successfully');
    } else {
      print('Failed to submit data. Error: ${response.statusCode}');
    }
  }

  Future<List> fetchSleepData() async {
    try {
      String numberString = "${globalUserMaster?.id}";
      print(globalUserMaster?.height);
      // CommonUtils.showProgressDialog();

      final url = Uri.parse(
          '${ApiUrl.SLEEP_HISTORY_PHP}?user_id=' +
              numberString);

      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        dynamic responseBody = json.decode(response.body);
        print(
            'get fetchSleepData  successfully=====================================');
        if (responseBody is List) {
          sleeptHistory = responseBody;
          print(response.body);
          notifyListeners();
          return responseBody.toList();
        } else {
          print('fetchSleepData: Received non-list json response: ${response.body}');
          sleeptHistory = [];
          notifyListeners();
          return [];
        }
      } else {
        print('Error fetchSleepData status code: ${response.statusCode}, body: ${response.body}');
        sleeptHistory = [];
        notifyListeners();
        return [];
      }
    } catch (e, stack) {
      print('Exception in fetchSleepData: $e');
      print(stack);
      sleeptHistory = [];
      notifyListeners();
      return [];
    }
  }
}
