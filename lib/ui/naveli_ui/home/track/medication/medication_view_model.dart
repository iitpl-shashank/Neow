import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../../../database/app_preferences.dart';
import '../../../../../generated/i18n.dart';
import '../../../../../models/common_master.dart';
import '../../../../../models/madication_master.dart';
import '../../../../../models/user_medicine_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/global_variables.dart';
import 'package:http/http.dart' as http;

class MedicationViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<MedicationData>? medicineList = [];
  List<String> userPreviousMedication = [];
  List<OtherMedicine> storedOtherMedicineList = [];
  List<int?> selectedMedicationsIdList = [];
  bool isExist = false;

  // List<String?> selectedMedicationsName = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getMedicineListApi(String aid) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    CommonMedicationAilmentMaster? master =
        await _services.api!.getMedicineName(params: params);
    CommonUtils.hideProgressDialog();
    if (master != null && master.success! && master.data != null) {
      medicineList = master.data;
      for (var fruit in medicineList!) {
        print("================================================fruit");
        print(fruit.name);
        print("================================================fruit");
      }
      print("================================================medicineList");
      print(medicineList?.toString());
      print("================================================medicineList");
      await getStoredMedicineListApi(true, aid);
    } else if (master != null && !master.success!) {
      CommonUtils.showSnackBar(
        master.message ?? S.of(mainNavKey.currentContext!)!.userDataSyncFailed,
        color: CommonColors.mRed,
      );
    }
    notifyListeners();
  }

  Future<void> storeOtherAlimentsCustome({
    required List<int?> medicationsId,
    otherMedicine,
    String? aid,
  }) async {
    String numberString = "${globalUserMaster?.id}";
    print(otherMedicine.toString());

    CommonUtils.showProgressDialog();

    final url = Uri.parse('https://neowindia.com/customeApi/medication.php');

    // Create headers
    final headers = {
      'Content-Type': 'application/json',
    };

    // Serialize the other_medicine list as JSON string
    final Map<String, dynamic> data = {
      "user_id": numberString,
      "medicine_id": "1",
      "other_medicine": jsonEncode(
          otherMedicine), // Use jsonEncode for proper JSON serialization
      "aid": aid,
    };

    // Send the request
    final response = await http.post(
      url,
      headers: headers, // Don't forget to add headers here
      body: jsonEncode(data), // Ensure the body is properly encoded as JSON
    );

    CommonUtils.hideProgressDialog();

    // Handle the response
    print(response);
    if (response.statusCode == 200) {
      print('Data submitted successfully');
      CommonUtils.showSnackBar(
        'Data submitted  successfully',
        color: CommonColors.greenColor,
      );
      getDataWithaid(aid);
      notifyListeners();
    } else {
      print('Failed to submit data. Error: ${response.statusCode}');
    }
  }

  Future<List?> getDataWithaid(aid) async {
    CommonUtils.showProgressDialog();
    storedOtherMedicineList.clear();
    String numberString = "$aid";
    print(globalUserMaster?.height);
    String uId = "${globalUserMaster?.id}";

    final url = Uri.parse(
      'https://neowindia.com/customeApi/medication.php?aid=' +
          numberString +
          '&user_id=' +
          uId,
    );

    final headers = {
      'Content-Type': 'application/json',
    };
    print(url);

    final response = await http.get(url, headers: headers);
    CommonUtils.hideProgressDialog();
    print('Get Data Response: ${response.body}');
    if (response.statusCode == 200) {
      if (json.decode(response.body)["status"] == "error") {
        storedOtherMedicineList.clear();
        return null;
      }
      try {
        List<dynamic> responseBody =
            json.decode(response.body)['data']; // Extract 'data' from response
        print('Data fetched successfully');

        // List to store processed other_medicine objects

        // Iterate over each record to process 'other_medicine'
        for (var record in responseBody) {
          String recordValue =
              jsonEncode({...record, "id": record['id'].toString()});
          print('=====================================recordValue');
          print(recordValue);

          if (record['other_medicine'] != null &&
              record['other_medicine'].isNotEmpty) {
            dynamic otherMedicineData = record['other_medicine'];

            // Check if 'other_medicine' is a String (JSON string) or List (already decoded)
            if (otherMedicineData is String) {
              // Decode the JSON string to a list of maps
              List<dynamic> otherMedicineList = json.decode(otherMedicineData);

              // Convert each element of the list to an instance of OtherMedicine
              for (var item in otherMedicineList) {
                String jsonString = jsonEncode(item);
                print('=====================================');
                print(jsonString);
                print(record['id']);
                print('=====================================');

                storedOtherMedicineList.add(OtherMedicine.fromJson({
                  ...item,
                  "id": record['id'].toString(),
                  "date": record['created_at']
                })); // Add to list
              }
            } else if (otherMedicineData is List) {
              // If it's already a List, just convert each element
              for (var item in otherMedicineData) {
                String jsonString =
                    jsonEncode({...item, "id": record['id'].toString()});
                print('=====================================');
                print(jsonString);
                // print(record['id']);
                print('=====================================');
                storedOtherMedicineList.add(OtherMedicine.fromJson({
                  ...item,
                  "id": record['id'].toString(),
                  "date": record['created_at']
                })); // Add to list
              }
            }
          }
        }

        // Now storedOtherMedicineList contains the OtherMedicine objects
        // print('Stored Other Medicine List: $storedOtherMedicineList');

        if (storedOtherMedicineList.isEmpty) {
          storedOtherMedicineList.clear();
        }
        // Optionally, you can store it in a variable or update the UI
        notifyListeners();
        return responseBody;
      } catch (e) {
        print('Error parsing response: $e');
        throw Exception('Failed to parse data');
      }
    } else {
      print('Error fetching data');
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteMedication(String aid, id) async {
    final String baseUrl = 'https://neowindia.com/customeApi/medication.php';
    final Uri url = Uri.parse('$baseUrl?aid=$aid');
    print(url);

    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        // If the server returns a successful response
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Check the status from the response
        if (responseBody['status'] == 'success') {
          print('Record deleted successfully');
          CommonUtils.showSnackBar(
            'Record deleted successfully',
            color: CommonColors.greenColor,
          );
          getDataWithaid(id);
          // Handle success (e.g., update the UI or show a success message)
        } else {
          print('Record deleted successfully');
          CommonUtils.showSnackBar(
            'Failed to delete record',
            color: const Color.fromARGB(255, 233, 92, 92),
          );
          print('Failed to delete record: ${responseBody['message']}');
          // Handle error (e.g., show an error message)
        }
      } else {
        // If the server response is not successful
        print(
            'Failed to connect to the server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors during the API call
      print('Error deleting record: $e');
    }
  }

  void updateSelectedMedicineFromStored(List<MedicineId>? storedMedicineIds) {
    if (storedMedicineIds != null && medicineList != null) {
      for (MedicineId? storedId in storedMedicineIds) {
        if (storedId != null) {
          final foundMedicine = medicineList!.firstWhere(
            (medicine) => medicine.id == storedId.id,
          );
          foundMedicine.isSelected = true;
        }
      }
    }
  }

  Future<void> getStoredMedicineListApi(
      bool isMedicationScreen, String aid) async {
    if (isMedicationScreen) {
      CommonUtils.showProgressDialog();
    }
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
      ApiParams.aid: aid,
    };
    UserMedicineMaster? master =
        await _services.api!.getStoredMedicationsDetail(params: params);
    if (isMedicationScreen) {
      CommonUtils.hideProgressDialog();
    }
    // print('${master?.data}');
    if (master != null && master.success! && master.data != null) {
      if (isMedicationScreen) {
        updateSelectedMedicineFromStored(master.data!.medicineId);
      }
      if (master.data?.medicineId != []) {
        master.data?.medicineId?.forEach((medication) {
          userPreviousMedication.add(medication.name ?? '');
        });
        print("................${userPreviousMedication.length}");
      }
      isExist = false;
      print("................${master.data?.otherMedicine?.length}");
      storedOtherMedicineList = master.data?.otherMedicine ?? [];
    } else if (master != null && !master.success!) {}
    notifyListeners();
  }

  Future<void> storeUserMedicationsApi(
      {required List<int?> medicationsId,
      List<OtherMedicine>? otherMedicine,
      String? aid}) async {
    CommonUtils.showProgressDialog();
    print("................${otherMedicine?.length}");
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.medicine_id: medicationsId,
      ApiParams.other_medicine: otherMedicine,
      ApiParams.aid: aid.toString(),
    };
    // log(params.toString());
    // print(params.toString());
    CommonMaster? master =
        await _services.api!.storeUserMedications(params: params);
    CommonUtils.hideProgressDialog();
    // print(master?.toJson() ?? '');
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................medication oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      getMedicineListApi(aid ?? '');
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }
}
