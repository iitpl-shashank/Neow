import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../../../database/app_preferences.dart';
import '../../../../models/saved_post_master.dart';
import '../../../../models/post_model.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class SavedPostViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  List<SavedPost> savedPostsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getSavedPostsApi({bool isRefresh = false}) async {
    if (isLoading) return;
    if (!isRefresh && !hasMore) return;

    isLoading = true;
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      savedPostsList.clear();
    }
    notifyListeners();

    Map<String, dynamic> queryParams = {
      'page': currentPage,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };

    SavedPostMaster? master =
        await _services.api!.getSavedPosts(queryParams: queryParams);

    isLoading = false;
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      final data = master.data?.data ?? [];
      final pagination = master.data?.pagination;

      savedPostsList.addAll(data);

      if (pagination != null) {
        if (currentPage >= (pagination.lastPage ?? 1)) {
          hasMore = false;
        } else {
          currentPage++;
        }
      } else {
        hasMore = false;
      }
    }
    notifyListeners();
  }

  Future<void> removeSavedPostApi(
      {required int? postId, required int index}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.post_id: postId,
      ApiParams.is_saved: 0, // Unsave
    };
    PostModel? master = await _services.api!.savePostApi(params: params);
    CommonUtils.hideProgressDialog();
    if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      savedPostsList.removeAt(index);
      CommonUtils.showSnackBar(
        master.message ?? "Post removed from saved list",
        color: CommonColors.primaryColor,
      );
    }
    notifyListeners();
  }
}
