import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/download_pdf_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class ReportsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  Future<void> downloadReportPdfApi({
    required String? name,
    required String? mobile,
    required String? email,
    required String? uniqueId,
    required String? birthday,
    required String? age,
    required String? ageGroup,
    required String? medication,
    required String? ailments,
    required String? weight,
    required String? sleep,
    required String? bmi,
    required String? staining,
    required String? clotSize,
    required String? workingAbility,
    required String? location,
    required String? periodCramps,
    required String? days,
    required String? stress,
    required String? pms,
    required String? pco,
    required String? anemia,
    required String? periodLength,
    required String? cycleLength,
    required String? lastPeriodDate,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.name: name,
      ApiParams.mobile: mobile,
      ApiParams.email: email,
      ApiParams.unique_id: uniqueId,
      ApiParams.birthdate: birthday,
      ApiParams.age: age,
      ApiParams.age_group: ageGroup,
      ApiParams.medications: medication,
      ApiParams.ailments: ailments,
      ApiParams.weight: weight,
      ApiParams.sleep: sleep,
      ApiParams.bmi: bmi,
      ApiParams.staining: staining,
      ApiParams.clot_size: clotSize,
      ApiParams.working_ability: workingAbility,
      ApiParams.location: location,
      ApiParams.period_cramps: periodCramps,
      ApiParams.days: days,
      ApiParams.stress: stress,
      ApiParams.pms: pms,
      ApiParams.pco: pco,
      ApiParams.anemia: anemia,
      ApiParams.average_period_length: periodLength,
      ApiParams.average_cycle_length: cycleLength,
      ApiParams.previous_periods_begin: lastPeriodDate,
    };
    log(params.toString());
    DownloadPdfMaster? master =
        await _services.api!.downloadReportPdf(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................report oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      launchUrl(master.data?.pdfPath ?? '');
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      // Navigator.of(context).pop();
    }
    notifyListeners();
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
    notifyListeners();
  }
}
