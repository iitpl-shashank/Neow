import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:naveli_2023/models/about_us_master.dart';
import 'package:naveli_2023/models/buddy_request_master.dart';
import 'package:naveli_2023/models/healthmix_latest_posts.dart';
import 'package:naveli_2023/models/login_master.dart';
import 'package:naveli_2023/models/monthly_reminder_master.dart';
import 'package:naveli_2023/services/api_url.dart';

import '../models/about_your_cycle_master.dart';
import '../models/all_about_periods_details_master.dart';
import '../models/all_about_periods_master.dart';
import '../models/all_posts_master.dart';
import '../models/ask_question_master.dart';
import '../models/bmi_master.dart';
import '../models/buddy_already_send_request_master.dart';
import '../models/check_device_token_master.dart';
import '../models/city_master.dart';
import '../models/common_master.dart';
import '../models/daily_diary_master.dart';
import '../models/download_pdf_master.dart';
import '../models/festival_master.dart';
import '../models/forum_comment_master.dart';
import '../models/forum_post_master.dart';
import '../models/health_mix_liked_post_master.dart';
import '../models/health_mix_posts_master.dart';
import '../models/healthmix_category_model.dart';
import '../models/madication_master.dart';
import '../models/monthly_mission_master.dart';
import '../models/question_answer_master.dart';
import '../models/question_of_day_master.dart';
import '../models/quiz_master.dart';
import '../models/quiz_question_master.dart';
import '../models/reflection_master.dart';
import '../models/signup_master.dart';
import '../models/sleep_master.dart';
import '../models/slider_video_master.dart';
import '../models/state_master.dart';
import '../models/sub_question_master.dart';
import '../models/user_ailments_master.dart';
import '../models/user_details_master.dart';
import '../models/user_medicine_master.dart';
import '../models/user_symptoms_master.dart';
import '../models/user_symptoms_score_master.dart';
import '../models/water_master.dart';
import '../models/weight_master.dart';
import '../models/women_news_master.dart';
import '../utils/common_utils.dart';
import '../utils/global_variables.dart';
import 'base_client.dart';
import 'base_services.dart';

class ApiServices extends BaseServices {
  AppBaseClient appBaseClient = AppBaseClient();

  @override
  Future<SignupMaster?> signUp({required Map<String, String> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
      url: ApiUrl.SIGN_UP,
      postParams: params,
      // onFailed: (String message) {
      //   CommonUtils.showToastMessage(message);
      // },
    );
    if (response != null) {
      try {
        return SignupMaster.fromJson(response);
      } on Exception catch (e) {
        CommonUtils.showToastMessage(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> getDateWiseText(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.DynamicText, postParams: params);
    debugPrint("response in overriding $response");

    return response;
  }

  @override
  Future<Map<String, dynamic>> postUserSymptoms(
      {required Map<String, dynamic> body}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.logSymptoms, postParams: body);
    debugPrint("response in overriding $response");

    return response;
  }

  @override
  Future<LoginMaster?> login({required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithoutTokenCall(
        url: ApiUrl.LOGIN, postParams: params);
    if (response != null) {
      try {
        return LoginMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> verifyMobile(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithoutTokenCall(
      url: ApiUrl.VERIFY_MOBILE,
      postParams: params,
    );
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserDetailMaster?> getUserDetails() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.USER_DETAIL,
    );
    if (response != null) {
      try {
        return UserDetailMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> logoutApi() async {
    dynamic res = await appBaseClient.getApiWithTokenCall(url: ApiUrl.LOGOUT);
    if (res != null) {
      try {
        return CommonMaster.fromJson(res);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> userUpdateDetails({
    required Map<String, dynamic> params,
  }) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
      url: ApiUrl.USER_UPDATE_DETAILS,
      postParams: params,
    );

    debugPrint("response $response");
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> userUpdateDashboard({
    required Map<String, dynamic> params,
    required String picture,
    String? fileKey,
  }) async {
    dynamic response = await appBaseClient.postFormDataApiCall(
      url: ApiUrl.USER_UPDATE_DASHBOARD,
      postParams: params,
      images: picture.isNotEmpty ? [File(picture)] : [],
      fileKey: fileKey,
    );
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> userSymptomsLog(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.USER_SYMPTOMS_LOG, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserSymptomsMaster?> getUserSymptomsDetails(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_USER_SYMPTOMS_LOG, postParams: params);
    if (response != null) {
      try {
        return UserSymptomsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMedicationAilmentMaster?> getMedicineName(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_MEDICINE_LIST, postParams: params);
    if (response != null) {
      try {
        return CommonMedicationAilmentMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMedicationAilmentMaster?> getAilmentsName(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_AILMENTS_LIST, postParams: params);
    if (response != null) {
      try {
        return CommonMedicationAilmentMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeUserMedications(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_USER_MEDICATION, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeUserAilments(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_USER_AILMENTS, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserMedicineMaster?> getStoredMedicationsDetail(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_STORED_USER_MEDICATION, postParams: params);
    if (response != null) {
      try {
        return UserMedicineMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserAilmentsMaster?> getStoredAilmentsDetail(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_STORED_USER_AILMENTS, postParams: params);
    if (response != null) {
      try {
        return UserAilmentsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeUserBmi(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_USER_BMI, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeUserWeight(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_USER_WEIGHT, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AllPostsMaster?> getAllPosts(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_ALL_POSTS, postParams: params);
    if (response != null) {
      try {
        return AllPostsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<HealthMixPostMaster?> getHealthMixPosts(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_HEALTH_MIX_POSTS, postParams: params);
    if (response != null) {
      try {
        return HealthMixPostMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<QuizMaster?> getQuizCategory(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_QUIZ_CATEGORY, postParams: params);
    if (response != null) {
      try {
        return QuizMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<QuizQuestionMaster?> getQuizQuestions(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_QUIZ_QUESTION, postParams: params);
    if (response != null) {
      try {
        return QuizQuestionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<QuestionOfDayMaster?> storeQuestionOfDay(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_QUESTION_OF_DAY, postParams: params);
    if (response != null) {
      try {
        return QuestionOfDayMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AskQuestionMaster?> getAdminAnswer() async {
    dynamic response = await appBaseClient.getApiCallWithOutToken(
        url: ApiUrl.GET_ADMIN_ANSWER);
    if (response != null) {
      try {
        return AskQuestionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<WomenNewsMaster?> getWomenNews(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_WOMEN_NEWS, postParams: params);
    if (response != null) {
      try {
        return WomenNewsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ForumPostMaster?> getForumAllPost(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_FORUM_POST, postParams: params);
    if (response != null) {
      try {
        return ForumPostMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeForumComment(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_FORUM_COMMENT, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ForumCommentMaster?> getForumComment(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_FORUM_COMMENT, postParams: params);
    if (response != null) {
      try {
        return ForumCommentMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeQuestionAnswer(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_QUESTION_ANSWER, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<QuestionAnswerMaster?> getQuestionAnswer() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_QUESTION_ANSWER,
    );
    if (response != null) {
      try {
        return QuestionAnswerMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> likeHealthMixPost(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_HEALTHMIX_LIKE, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<LikedPostMaster?> getLikedHealthPost() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_LIKED_POST,
    );
    if (response != null) {
      try {
        return LikedPostMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeWaterDetail(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_WATER_DETAIL, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeSleepDetail(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_SLEEP_DETAIL, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<WeightMaster?> getWeightDetail() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_WEIGHT_DETAIL,
    );
    if (response != null) {
      try {
        return WeightMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<BmiMaster?> getBmiDetail() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_BMI_DETAIL,
    );
    if (response != null) {
      try {
        return BmiMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<WaterMaster?> getWaterDetail() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_WATER_DETAIL,
    );
    if (response != null) {
      try {
        return WaterMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AllAboutPeriodsMaster?> getAllAboutPeriodList(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_ALL_ABOUT_PERIODS_LIST, postParams: params);
    if (response != null) {
      try {
        return AllAboutPeriodsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AllAboutPeriodsDetailsMaster?> getAllAboutPeriodDetail(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_DETAILS_ALL_PERIOD, postParams: params);
    if (response != null) {
      try {
        return AllAboutPeriodsDetailsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<FestivalMaster?> getFestivalList(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_FESTIVAL, postParams: params);
    if (response != null) {
      try {
        return FestivalMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<StateMaster?> getStateList(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.getApiCallWithOutToken(
      url: ApiUrl.GET_STATE,
      queryParams: params,
    );
    if (response != null) {
      try {
        return StateMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CityMaster?> getCityList(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_CITY, postParams: params);
    if (response != null) {
      try {
        return CityMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeCity(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_CITY, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeState(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_STATE, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<SliderVideoMaster?> getHomeSliderVideo(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_SLIDER_VIDEO, postParams: params);
    if (response != null) {
      try {
        return SliderVideoMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeDailyDiary(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_DAILY_DIARY, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<SleepMaster?> getSleepDetails() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_STORED_SLEEP_DETAILS,
    );
    if (response != null) {
      try {
        return SleepMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<DailyDiaryMaster?> getDailyDiaryData(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_DAILY_DIARY, postParams: params);
    if (response != null) {
      try {
        return DailyDiaryMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<SubQuestionMaster?> getSubQuestion(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_SUB_QUESTION, postParams: params);
    if (response != null) {
      try {
        return SubQuestionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeHirsutism(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_HIRSUTISM, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<AboutUsMaster?> getAboutUsDetails() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_ABOUT_US,
    );
    if (response != null) {
      try {
        return AboutUsMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeMonthlyMission(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_MONTHLY_MISSION, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MonthlyMissionMaster?> getMonthlyMission() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_MONYHLY_MISSION,
    );
    if (response != null) {
      try {
        return MonthlyMissionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeSubQuestionAnswer(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_SUB_QUESTION_ANSWER, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<ReflectionMaster?> getReflection() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_REFLECTION,
    );
    if (response != null) {
      try {
        return ReflectionMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeMonthlyReminder(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.STORE_MONTHLY_REMINDER, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> verifyUniqueId(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.VERIFY_UNIQUE_ID, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<BuddyRequestMaster?> getBuddyRequestData() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_BUDDY_REQUEST,
    );
    if (response != null) {
      try {
        return BuddyRequestMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> storeNaveliAccountStatus(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.VERIFY_ACCOUNT_STATUS, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<BuddyAlreadySendRequestMaster?>
      getBuddyAlreadySendRequestData() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_BUDDY_SENDED_REQUEST,
    );
    if (response != null) {
      try {
        return BuddyAlreadySendRequestMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserDetailMaster?> getDataFromUniqueId(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_DATA_FROM_UNIQUE_ID, postParams: params);
    if (response != null) {
      try {
        return UserDetailMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MonthlyReminderMaster?> getMonthlyReminderData() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
      url: ApiUrl.GET_MONTHLY_REMINDER,
    );
    if (response != null) {
      try {
        return MonthlyReminderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MonthlyReminderMaster?> addMonthlyReminder(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithoutTokenCall(
        url: ApiUrl.ADD_MONTHLY_REMINDERS, postParams: params);
    if (response != null) {
      try {
        return MonthlyReminderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<DownloadPdfMaster?> downloadReportPdf(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.DOWNLOAD_REPORT_PDF, postParams: params);
    if (response != null) {
      try {
        return DownloadPdfMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<UserSymptomsScoreMaster?> getSymptomsScore(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.USER_SYMPTOMS_SCORE, postParams: params);
    if (response != null) {
      try {
        return UserSymptomsScoreMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CheckDeviceTokenMaster?> checkDeviceToken(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithoutTokenCall(
        url: ApiUrl.CHECK_DEVICE_TOKEN, postParams: params);
    if (response != null) {
      try {
        return CheckDeviceTokenMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<CommonMaster?> removeDeviceToken(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithoutTokenCall(
        url: ApiUrl.REMOVE_DEVICE_TOKEN, postParams: params);
    if (response != null) {
      try {
        return CommonMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<MonthlyReminderMaster?> getMonthlyRemindersList(
      {required Map<String, dynamic> params}) async {
    dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.GET_MONTHLY_REMINDERS, postParams: params);
    if (response != null) {
      try {
        return MonthlyReminderMaster.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<PeriodInfoListResponse?> getPeriodInfoList() async {
    dynamic response =
        await appBaseClient.getApiWithTokenCall(url: ApiUrl.GET_PERIOD_INFO);
    if (response != null) {
      debugPrint("PeriodInfoListResponse: $response");
      try {
        return PeriodInfoListResponse.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<PeriodInfoListResponse?> savePeriodsInfo(
      {required Map<String, dynamic> params}) async {
    // log("AddPerido: $params",name: ApiUrl.ADD_PERIOD_INFO);
    try {
      dynamic response = await appBaseClient.postApiWithTokenCall(
          url: ApiUrl.ADD_PERIOD_INFO, postParams: params);
      debugPrint("AddPerido: ${response}");
      if (response != null) {
        try {
          debugPrint("AddPerido: $response");
          return PeriodInfoListResponse.fromJson(response);
        } on Exception catch (e) {
          log("Exception :: $e");
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("Exception api:: $e");
      return null;
    }
  }

  @override
  Future<AboutYourCycleReponse?> getAboutYourCycle() async {
    dynamic response = await appBaseClient.getApiWithTokenCall(
        url: ApiUrl.GET_ABOUT_YOUR_CYCLE);
    debugPrint("response in overriding ${response}");
    if (response != null) {
      try {
        return AboutYourCycleReponse.fromJson(response);
      } on Exception catch (e) {
        log("Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> getDialogBoxData() async {
    dynamic response =
        await appBaseClient.getApiWithTokenCall(url: ApiUrl.notification);
    debugPrint("response in overriding ${response}");
    if (response != null) {
      try {
        return response;
      } on Exception catch (e) {
        log("Exception :: $e");
        return {};
      }
    } else {
      return {};
    }
  }

  @override
  Future<HealthMixCategoryModel?> getHealthMixCategoryList() async {
    try {
      dynamic response = await appBaseClient.getApiWithTokenCall(
        url: ApiUrl.getHealthMixCategoryList,
      );
      if (response != null) {
        debugPrint("HealthMixCategoryList Response: $response");
        return HealthMixCategoryModel.fromJson(response);
      } else {
        debugPrint("HealthMixCategoryList Response is null");
        return null;
      }
    } catch (e) {
      log("Exception in getHealthMixCategoryList: $e");
      return null;
    }
  }

  @override
  Future<HealthMixLatestPost?> getHealthMixLatestPostList(
      {required Map<String, dynamic> params}) async {
    try {
      dynamic response = await appBaseClient.postApiWithTokenCall(
        url: ApiUrl.getHealthMixLatestVideoList,
        postParams: params,
      );
      if (response != null) {
        debugPrint("HealthMixLatestPost Response: $response");
        return HealthMixLatestPost.fromJson(response);
      } else {
        debugPrint("HealthMixLatestPost Response is null");
        return null;
      }
    } on Exception catch (e) {
    } catch (e) {
      log("Exception in getHealthMixCategoryList: $e");
      return null;
    }
    ;
  }
}
