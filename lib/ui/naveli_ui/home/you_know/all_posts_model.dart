import 'package:flutter/cupertino.dart';

import '../../../../database/app_preferences.dart';
import '../../../../models/all_posts_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart'; 

class AllPostsModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<PostsData> postsList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
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
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      postsList = master.data?.postsData ?? [];
    }
    notifyListeners();
  }
}
