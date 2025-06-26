import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/post_model.dart';

import '../../../../database/app_preferences.dart';
import '../../../../models/all_posts_master.dart';
import '../../../../models/common_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AllPostsModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<PostsData> postsList = [];
  List<PostsData> likedPostsList = [];
  List<bool> isLikedList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> likeArticlePostApi({
    required int? postId,
    required int? isLike,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.post_id: postId,
      ApiParams.is_like: isLike,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.likeArticlePost(params: params);
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
    } else if (master.success == true) {}
    notifyListeners();
  }

  Future<void> saveUserPostApi({required Map<String, dynamic> params}) async {
    CommonUtils.showProgressDialog();
    PostModel? master = await _services.api!.savePostApi(params: params);
    CommonUtils.hideProgressDialog();
    if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {}
    notifyListeners();
  }

  Future<void> getAllPostsApi(
      {required int parentTitleId, required String filterBy}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.parent_title_id: parentTitleId,
      ApiParams.filter_by: filterBy,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };

    AllPostsMaster? master = await _services.api!.getAllPosts(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................all post model oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      postsList = master.data?.postsData ?? [];
      await getLikedPostApi(
          parentTitleId: parentTitleId, filterBy: filterBy, type: 'like');
    }
    notifyListeners();
  }

  Future<void> getLikedPostApi({
    required int parentTitleId,
    required String filterBy,
    required String type,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.parent_title_id: parentTitleId,
      ApiParams.filter_by: filterBy,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
      ApiParams.type: type,
    };

    AllPostsMaster? master = await _services.api!.getAllPosts(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................all post model oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      isLikedList.clear();
      likedPostsList = master.data?.postsData ?? [];
      for (var post in postsList) {
        isLikedList
            .add(likedPostsList.any((likedPost) => likedPost.id == post.id));
      }
    }
    notifyListeners();
  }

  //   Future<void> getLikedPostApi() async {
  //   CommonUtils.showProgressDialog();
  //   LikedPostMaster? master = await _services.api!.getLikedHealthPost();

  //   if (master == null) {
  //     CommonUtils.oopsMSG();
  //     print(
  //         "................................health mix oops.............................");
  //   } else if (master.success == false) {
  //     CommonUtils.showSnackBar(
  //       master.message ?? "--",
  //       color: CommonColors.mRed,
  //     );
  //     CommonUtils.hideProgressDialog();
  //   } else if (master.success == true) {
  //     final likedPosts = master.data ?? [];
  //     isLikedList.clear();
  //     for (var post in healthPostsList) {
  //       isLikedList.add(likedPosts.any((likedPost) =>
  //           likedPost.healthMixId == post.id && likedPost.isLike == 1));
  //     }
  //     print(".................$isLikedList");
  //     CommonUtils.hideProgressDialog();
  //   }
  //   notifyListeners();
  // }
}
