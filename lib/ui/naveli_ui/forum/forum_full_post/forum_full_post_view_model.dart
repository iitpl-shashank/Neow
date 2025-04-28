import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../models/common_master.dart';
import '../../../../models/forum_comment_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class ForumFullPostViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<CommentData> commentList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getForumsCommentApi({
    required int forumId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.forum_id: forumId,
    };
    log(params.toString());
    ForumCommentMaster? master =
        await _services.api!.getForumComment(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Forum full post oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      commentList = master.data ?? [];
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeForumCommentApi({
    required int forumId,
    required String comment,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.forum_id: forumId,
      ApiParams.comment: comment,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeForumComment(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Forum full post oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // Navigator.of(context).pop();
      getForumsCommentApi(forumId: forumId);
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }
}
