import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/weight_master.dart';
import 'package:http/http.dart' as http;
import 'package:naveli_2023/ui/naveli_ui/calendar/calendar_view.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../../../models/common_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class WeightViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  String selectedWeightValue = "";
  String selectedWeightType = '';
  int selectedIndex = 0;
  int kg = 0;
  int gm = 0;
  List<dynamic> weightHistory = [];
  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void selectWeightKg(int value) {
    kg = value;
    notifyListeners();
  }

  void selectWeightGm(int value) {
    gm = value;
    notifyListeners();
  }

  Future<void> getWeightDetailApi() async {
    CommonUtils.showProgressDialog();
    WeightMaster? master = await _services.api!.getWeightDetail();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................weight oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      if (master.data?.weight != null) {
        selectedWeightValue = master.data!.weight.toString();
      }
      if (master.data?.weightType == "Kg") {
        selectedIndex = 1;
        selectedWeightType = "Kg";
      }
      if (master.data?.weightType == "Lbs") {
        selectedIndex = 2;
        selectedWeightType = "Lbs";
      }
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeUserWeightApi({
    required String weight,
    required String weightType,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.weight: weight,
      ApiParams.weight_type: weightType,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.storeUserWeight(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................weight oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeWeightHistory({
    required String weight,
    required String weightType,
  }) async {
    String numberString = "${globalUserMaster?.id}";
    // CommonUtils.showProgressDialog();

    final url =
        Uri.parse('https://neowindia.com/customeApi/weight_history.php');

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

  Future<List<MonthData>> fetchWeightData() async {
    String numberString = "${globalUserMaster?.id}";
    print(globalUserMaster?.height);
    // CommonUtils.showProgressDialog();

    final url = Uri.parse(
        'https://neowindia.com/customeApi/weight_history.php?user_id=' +
            numberString);

    final response = await http.get(
      url,
    );
    CommonUtils.hideProgressDialog();
    // Handle the response
    print(url);
    print('==============================================================');
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      print('get Data successfully=====================================');
      //  responseBody.map((item) => weightHistory.add MonthData.fromJson(item));
      weightHistory = responseBody;
      print(response.body);
      return responseBody.map((item) => MonthData.fromJson(item)).toList();
    } else {
      print('Error=====================================');

      throw Exception('Failed to load data');
    }
  }
}
