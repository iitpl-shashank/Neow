import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/forum_category_model.dart';
import 'package:naveli_2023/services/api_para.dart';
import 'package:naveli_2023/services/index.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';

import '../../../../database/app_preferences.dart';

class InterestViewModel with ChangeNotifier {
  late BuildContext context;
  List<String> selectedOptions = [];
    final _services = Services();
  List<String> previousSelectedOptions = [];
  List<ForumCategory> forumCategoryList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> loadSelectedOptions() async {
    previousSelectedOptions = await AppPreferences.instance.getInterestFavourite() ?? [];
    selectedOptions = List.from(previousSelectedOptions);
    notifyListeners();
  }

  bool isFavoriteSelected(String title) {
    return selectedOptions.contains(title);
  }

  // bool isNotInterestedSelected(String title) {
  //   return !selectedOptions.contains(title);
  // }

  Future<void> addOption(String title) async {
    if (!selectedOptions.contains(title)) {
      selectedOptions.add(title);
      await AppPreferences.instance.setInterestFavourite(selectedOptions);
      notifyListeners();
    }
  }

  Future<void> removeOption(String title) async {
    if (selectedOptions.contains(title)) {
      selectedOptions.remove(title);
      await AppPreferences.instance.setInterestFavourite(selectedOptions);
      notifyListeners();
    }
  }

  Future<void> toggleOption(String title) async {
    if (selectedOptions.contains(title)) {
      await removeOption(title);
      loadSelectedOptions();
    } else {
      await addOption(title);
      loadSelectedOptions();
    }
    notifyListeners();
  }

   Future<void> getForumCategory() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    ForumCategoryModel? forums = await _services.api!.getForumCategory();
    CommonUtils.hideProgressDialog();
    if (forums == null) {
      CommonUtils.oopsMSG();

    } else if (forums.success == false) {
      CommonUtils.showSnackBar(
        forums.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (forums.success == true) {
      forumCategoryList = forums.data ?? [];
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}