import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../../database/app_preferences.dart';
import '../../../models/forum_post_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class ForumViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<ForumPost> forumPostList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

 Future<void> getForumPostApi() async {
  CommonUtils.showProgressDialog();

  Map<String, dynamic> params = <String, dynamic>{
    ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
  };

  try {
    
    // Call API and parse response into ForumPostModel
    final response = await _services.api!.getForumAllPost(params: params);

    ForumPostModel? master;
    if (response != null) {
      master = response;
      forumPostList=master.data??[];
    }

    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
      print(" Forum view response is null");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    }
    //  else if (master.success == true) {
    //   forumPostList = master.data ?? [];
    //   // Optional: show success message
    //   // CommonUtils.showSnackBar(
    //   //   master.message ?? "Success",
    //   //   color: CommonColors.greenColor,
    //   // );
    // }
 
   CommonUtils.hideProgressDialog();
  } catch (e, s) {
    CommonUtils.hideProgressDialog();
    print("Exception in getForumPostApi: $e");
    print(s);
    CommonUtils.oopsMSG();
  }

  notifyListeners();
}



  Future<void> forumPostLikeDislike({
  required int forumId,
  required int isLike,
}) async {
  CommonUtils.showProgressDialog();
      // ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
  try {
      
    final params = <String, dynamic>{
      ApiParams.forumId: forumId,
      ApiParams.isLike: isLike,
    };
    final resp = await _services.api!.forumPostLikeDislike(params: params);
   
    CommonUtils.hideProgressDialog();

    if (resp.success == true) {
    
      forumPostList = resp.data ?? [];
      CommonUtils.showSnackBar(
        resp.message,
        color: CommonColors.greenColor,
      );
    } else if (resp.success == false) {
      
      CommonUtils.showSnackBar(
        resp.message,
        color: CommonColors.mRed,
      );
    } else {
 
      CommonUtils.oopsMSG();
    }
       await getForumPostApi();
  } catch (e) {
    CommonUtils.hideProgressDialog();
    log("Exception :: $e");
    CommonUtils.oopsMSG();
  }

  notifyListeners();
}

Future<void> forumPostSaveUnsave({
  required int forumId,
  required int isSaved,
}) async {
  CommonUtils.showProgressDialog();
      // ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
  try {
      
    final params = <String, dynamic>{
      ApiParams.forumId: forumId,
      ApiParams.is_saved: isSaved,
    };
    final resp = await _services.api!.forumPostSaveUnsave(params: params);
   
    CommonUtils.hideProgressDialog();

    if (resp.success == true) {
    
      forumPostList = resp.data ?? [];
      CommonUtils.showSnackBar(
        resp.message,
        color: CommonColors.greenColor,
      );
    } else if (resp.success == false) {
      
      CommonUtils.showSnackBar(
        resp.message,
        color: CommonColors.mRed,
      );
    } else {
 
      CommonUtils.oopsMSG();
    }
       await getForumPostApi();
  } catch (e) {
    CommonUtils.hideProgressDialog();
    log("Exception :: $e");
    CommonUtils.oopsMSG();
  }

  notifyListeners();



}
Future<void> forumPostComment({
  required String comment,
  required int forumId,
}) async {
  CommonUtils.showProgressDialog();

  try {
    final params = <String, dynamic>{
      ApiParams.forumId: forumId,
      ApiParams.comment: comment,
    };

    final resp = await _services.api!.forumPostComment(params: params);

    CommonUtils.hideProgressDialog();

    if (resp["success"] == true) {
      CommonUtils.showSnackBar(
        resp["message"] ?? "--",
        color: CommonColors.greenColor,
      );
    } else if (resp["success"] == false) {
      CommonUtils.showSnackBar(
        resp["message"] ?? "--",
        color: CommonColors.mRed,
      );
    } else {
      CommonUtils.oopsMSG();
    }

    // Refresh the forum posts after adding comment
    await getForumPostApi();
  } catch (e) {
    CommonUtils.hideProgressDialog();
    log("Exception :: $e");
    CommonUtils.oopsMSG();
  }

  notifyListeners();
}

}

