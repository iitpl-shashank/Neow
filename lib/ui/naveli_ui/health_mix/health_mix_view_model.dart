import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../database/app_preferences.dart';
import '../../../models/common_master.dart';
import '../../../models/health_mix_liked_post_master.dart';
import '../../../models/health_mix_posts_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class HealthMixViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<HealthMixPosts> healthPostsList = [];

  List<bool> isLikedList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  // void covertStringToList() {
  //   String hashtagsString = "#period, #sideeffect, #homeremedies, #Wellness, #diet, #personalhygiene";
  //
  //   List<String> hashtagsList = hashtagsString.split(',').map((tag) => tag.trim()).toList();
  //
  //   print(hashtagsList);
  // }

  Future<void> getLikedPostApi() async {
    CommonUtils.showProgressDialog();
    LikedPostMaster? master = await _services.api!.getLikedHealthPost();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      final likedPosts = master.data ?? [];
      isLikedList.clear();
      for (var post in healthPostsList) {
        isLikedList.add(likedPosts.any((likedPost) =>
            likedPost.healthMixId == post.id && likedPost.isLike == 1));
      }
      print(".................$isLikedList");
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> likeHealthMixPostApi({
    required int? healthMixId,
    required int? isLike,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.health_mix_id: healthMixId,
      ApiParams.is_like: isLike,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.likeHealthMixPost(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
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

  Future<void> getHealthMixPostsApi({required int titleId,required String type}) async {

    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.title_id: titleId,
      "type": type,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    debugPrint("params: $params");
    HealthMixPostMaster? master =
        await _services.api!.getHealthMixPosts(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
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
      healthPostsList = master.data?.healthMixPosts ?? [];
      debugPrint("healthPostsList: $healthPostsList");
      // isLikedList = List.generate(healthPostsList.length, (_) => false);
      await getLikedPostApi();
    }
    notifyListeners();
  }
}
