import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naveli_2023/database/app_preferences.dart';
import 'package:naveli_2023/models/shorts_model.dart';
import 'package:naveli_2023/services/api_url.dart';
import 'package:naveli_2023/services/index.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';

class ShortsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<ShortsData> shortsPostsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getShortsPostsApi({
    required String shortType,
    required String type,
    int? page,
    bool isRefresh = false,
  }) async {
    String accessToken = await AppPreferences.instance.getAccessToken();
    if (isLoading || (!hasMore && !isRefresh)) return;
    isLoading = true;
    notifyListeners();

    if (isRefresh) {
      shortsPostsList.clear();
      currentPage = 1;
      hasMore = true;
    }

    final int fetchPage = page ?? currentPage;
    var headers = {
      'Authorization': 'Bearer $accessToken',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiUrl.getAllShorts}?page=$fetchPage'),
    );
    request.fields.addAll({
      'short_type': shortType,
      'type': type,
    });
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        log("Shorts data: $data");
        List<dynamic> newPosts = data['data']['PostsData'] ?? [];
        if (newPosts.isNotEmpty) {
          shortsPostsList.addAll(newPosts.map((e) => ShortsData.fromJson(e)));
          currentPage = fetchPage + 1;
        } else {
          hasMore = false;
        }
      } else {
        CommonUtils.showSnackBar(
          "Failed to load shorts: ${response.reasonPhrase}",
          color: Colors.red,
        );
        hasMore = false;
      }
    } catch (e) {
      log("Error in getShortsPostsApi: $e");
      // CommonUtils.showSnackBar(
      //   "No new shorts available",
      //   color: Colors.red,
      // );
      hasMore = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> likeOrDislikeShort({
    required String shortId,
    required bool isLike,
  }) async {
    String accessToken = await AppPreferences.instance.getAccessToken();
    var headers = {
      'Authorization': 'Bearer $accessToken',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiUrl.userShortsLikeDislike}'),
    );
    request.fields.addAll({
      'short_id': shortId,
      'is_like': isLike ? '1' : '0',
    });
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        if (data['success'] == true) {
          // CommonUtils.showSnackBar(data['message'] ?? "Success",
          //     color: CommonColors.primaryColor);
          return true;
        } else {
          CommonUtils.showSnackBar(
            data['message'] ?? "Failed",
            color: Colors.red,
          );
          return false;
        }
      } else {
        CommonUtils.showSnackBar(
          "Failed: ${response.reasonPhrase}",
          color: Colors.red,
        );
        return false;
      }
    } catch (e) {
      log("Error in likeOrDislikeShort: $e");
      CommonUtils.showSnackBar(
        "Something went wrong",
        color: Colors.red,
      );
      return false;
    }
  }
}
