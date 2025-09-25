import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/models/forum_category_model.dart';
import 'package:naveli_2023/services/api_para.dart';
import 'package:naveli_2023/services/index.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';

import '../../../../database/app_preferences.dart';

class InterestViewModel with ChangeNotifier {
  final PageController pageController = PageController(
    initialPage: 0,
  );

  int currentIndex = 0;

  List<String> selectedOptions = [];
  final _services = Services();
  List<String> previousSelectedOptions = [];
  List<Category> forumCategoryList = [];

  Future<void> getForumCategory() async {
    CommonUtils.showProgressDialog();
    // Map<String, dynamic> params = <String, dynamic>{
    //   ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    // };
    ForumCategoryResponse? forums = await _services.api!.getForumCategory();
    CommonUtils.hideProgressDialog();
    if (forums.success == false) {
      CommonUtils.showSnackBar(
        forums.message ?? "Something went wrong",
        color: CommonColors.mRed,
      );
    } else if (forums.success == true) {
      forumCategoryList = forums.data ?? [];
      //  CommonUtils.showSnackBar(
      //   forums.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  void onPageSelected(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  Future<void> handleFavouriteSelection(
      int subCategoryId, bool isSelected) async {
    try {
      CommonUtils.showProgressDialog();

      Map<String, dynamic> params = <String, dynamic>{
        ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
        ApiParams.categoryId: subCategoryId,
        ApiParams.isLike: isSelected ? 0 : 1,
      };

      final CommonMaster response =
          await _services.api!.updateFavouriteCatgoryStatus(
        params: params,
      );

      CommonUtils.hideProgressDialog();

      if (response.success == true) {
        CommonUtils.showSnackBar(
          !isSelected ? "Added to favourites" : "Removed from favourites",
          color: CommonColors.greenColor,
        );

        // Optionally refresh the data
        await getForumCategory(); // If you want to refresh the list
      } else {
        CommonUtils.showSnackBar(
          response.message ?? "Failed to update favourite status",
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      CommonUtils.hideProgressDialog();
      CommonUtils.showSnackBar(
        "Error updating favourite status",
        color: CommonColors.mRed,
      );
    }

    notifyListeners();
  }
}
