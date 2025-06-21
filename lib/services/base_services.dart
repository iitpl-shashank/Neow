import 'package:naveli_2023/models/healthmix_latest_posts.dart';
import 'package:naveli_2023/models/signup_master.dart';
import 'package:naveli_2023/models/vaccination_model.dart';
import '../models/about_us_master.dart';
import '../models/about_your_cycle_master.dart';
import '../models/all_about_periods_details_master.dart';
import '../models/all_about_periods_master.dart';
import '../models/all_posts_master.dart';
import '../models/ask_question_master.dart';
import '../models/bmi_master.dart';
import '../models/buddy_already_send_request_master.dart';
import '../models/buddy_request_master.dart';
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
import '../models/login_master.dart';
import '../models/madication_master.dart';
import '../models/monthly_mission_master.dart';
import '../models/monthly_reminder_master.dart';
import '../models/period_log_model.dart';
import '../models/post_model.dart';
import '../models/question_answer_master.dart';
import '../models/question_of_day_master.dart';
import '../models/quiz_master.dart';
import '../models/quiz_question_master.dart';
import '../models/reflection_master.dart';
import '../models/sleep_master.dart';
import '../models/slider_video_master.dart';
import '../models/state_master.dart';
import '../models/sub_question_master.dart';
import '../models/symptom_report_model.dart';
import '../models/user_ailments_master.dart';
import '../models/user_details_master.dart';
import '../models/user_medicine_master.dart';
import '../models/user_symptoms_master.dart';
import '../models/user_symptoms_score_master.dart';
import '../models/water_master.dart';
import '../models/weight_master.dart';
import '../models/women_news_master.dart';
import '../ui/naveli_ui/ai_chatbot/model/ai_chatbot_model.dart';
import '../ui/naveli_ui/home/user_notifications/model/notification_list_model.dart';
import '../utils/global_variables.dart';

abstract class BaseServices {
  Future<SignupMaster?> signUp({required Map<String, String> params});

  Future<LoginMaster?> login({required Map<String, dynamic> params});

  Future<CommonMaster?> verifyMobile({required Map<String, dynamic> params});

  Future<Map<String, dynamic>> getDateWiseText(
      {required Map<String, dynamic> params});

  Future<UserDetailMaster?> getUserDetails();

  Future<CommonMaster?> logoutApi();

  Future<CommonMaster?> removeDeviceToken(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> userUpdateDetails({
    required Map<String, dynamic> params,
  });

  Future<CommonMaster?> userUpdateDashboard({
    required Map<String, dynamic> params,
    required String picture,
    String? fileKey,
  });

  Future<CommonMaster?> userSymptomsLog({required Map<String, dynamic> params});

  Future<UserSymptomsMaster?> getUserSymptomsDetails(
      {required Map<String, dynamic> params});

  Future<CommonMedicationAilmentMaster?> getMedicineName(
      {required Map<String, dynamic> params});

  Future<CommonMedicationAilmentMaster?> getAilmentsName(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeUserMedications(
      {required Map<String, dynamic> params});

  Future<UserMedicineMaster?> getStoredMedicationsDetail(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeUserAilments(
      {required Map<String, dynamic> params});

  Future<UserAilmentsMaster?> getStoredAilmentsDetail(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeUserBmi({required Map<String, dynamic> params});

  Future<CommonMaster?> storeUserWeight({required Map<String, dynamic> params});

  Future<AllPostsMaster?> getAllPosts({required Map<String, dynamic> params});

  Future<HealthMixPostMaster?> getHealthMixPosts(
      {required Map<String, dynamic> params});

  Future<HealthMixLatestPost?> getHealthMixLatestPostList(
      {required Map<String, dynamic> params});

  Future<CheckDeviceTokenMaster?> checkDeviceToken(
      {required Map<String, dynamic> params});

  Future<QuizMaster?> getQuizCategory({required Map<String, dynamic> params});

  Future<QuizQuestionMaster?> getQuizQuestions(
      {required Map<String, dynamic> params});

  Future<QuestionOfDayMaster?> storeQuestionOfDay(
      {required Map<String, dynamic> params});

  Future<AskQuestionMaster?> getAdminAnswer();

  Future<WomenNewsMaster?> getWomenNews({required Map<String, dynamic> params});

  Future<ForumPostMaster?> getForumAllPost(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeForumComment(
      {required Map<String, dynamic> params});

  Future<ForumCommentMaster?> getForumComment(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeQuestionAnswer(
      {required Map<String, dynamic> params});

  Future<QuestionAnswerMaster?> getQuestionAnswer();

  Future<CommonMaster?> likeHealthMixPost(
      {required Map<String, dynamic> params});

  Future<LikedPostMaster?> getLikedHealthPost();

  Future<CommonMaster?> storeWaterDetail(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeSleepDetail(
      {required Map<String, dynamic> params});

  Future<WeightMaster?> getWeightDetail();

  Future<BmiMaster?> getBmiDetail();

  Future<WaterMaster?> getWaterDetail();

  Future<AllAboutPeriodsMaster?> getAllAboutPeriodList(
      {required Map<String, dynamic> params});

  Future<AllAboutPeriodsDetailsMaster?> getAllAboutPeriodDetail(
      {required Map<String, dynamic> params});

  Future<FestivalMaster?> getFestivalList(
      {required Map<String, dynamic> params});

  Future<MonthlyReminderMaster?> getMonthlyRemindersList(
      {required Map<String, dynamic> params});

  Future<StateMaster?> getStateList({required Map<String, dynamic> params});

  Future<CityMaster?> getCityList({required Map<String, dynamic> params});

  Future<CommonMaster?> storeCity({required Map<String, dynamic> params});

  Future<CommonMaster?> storeState({required Map<String, dynamic> params});

  Future<SliderVideoMaster?> getHomeSliderVideo(
      {required Map<String, dynamic> params});

  Future<PeriodLogModel?> getIsPeriodLog({required String uniqueId});

  Future<CommonMaster?> storeDailyDiary({required Map<String, dynamic> params});

  Future<SleepMaster?> getSleepDetails();

  Future<DailyDiaryMaster?> getDailyDiaryData(
      {required Map<String, dynamic> params});

  Future<SubQuestionMaster?> getSubQuestion(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeHirsutism({required Map<String, dynamic> params});

  Future<AboutUsMaster?> getAboutUsDetails();

  Future<CommonMaster?> storeMonthlyMission(
      {required Map<String, dynamic> params});

  Future<MonthlyMissionMaster?> getMonthlyMission();

  Future<ReflectionMaster?> getReflection();

  Future<CommonMaster?> storeSubQuestionAnswer(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> storeMonthlyReminder(
      {required Map<String, dynamic> params});

  Future<CommonMaster?> verifyUniqueId({required Map<String, dynamic> params});

  Future<BuddyRequestMaster?> getBuddyRequestData();

  Future<DownloadPdfMaster?> downloadReportPdf(
      {required Map<String, dynamic> params});

  Future<UserDetailMaster?> getDataFromUniqueId(
      {required Map<String, dynamic> params});

  Future<BuddyAlreadySendRequestMaster?> getBuddyAlreadySendRequestData();

  Future<CommonMaster?> storeNaveliAccountStatus(
      {required Map<String, dynamic> params});

  Future<MonthlyReminderMaster?> getMonthlyReminderData();

  Future<UserSymptomsScoreMaster?> getSymptomsScore(
      {required Map<String, dynamic> params});

  Future<MonthlyReminderMaster?> addMonthlyReminder(
      {required Map<String, dynamic> params});

  Future<PeriodInfoListResponse?> getPeriodInfoList();

  Future<PeriodInfoListResponse?> savePeriodsInfo(
      {required Map<String, dynamic> params});

  Future<AboutYourCycleReponse?> getAboutYourCycle();

  Future<Map<String, dynamic>> postUserSymptoms(
      {required Map<String, dynamic> body});

  Future<Map<String, dynamic>> getDialogBoxData();

  Future<HealthMixCategoryModel?> getHealthMixCategoryList(
      {required Map<String, dynamic> params});

  Future<SymptomReportModel?> getSymptomReportList(
      {required Map<String, dynamic> params});

  Future<VaccinationModel?> getVaccinationInfo();

  Future<VaccinationModel?> saveVaccinationInfo(
      {required Map<String, dynamic> params});

  Future<AiChatBotModel?> startChatbotApi(
      {required Map<String, dynamic> params});

  Future<PostModel> savePostApi({required Map<String, dynamic> params});

  Future<PostModel> saveHealthMixPost({required Map<String, dynamic> params});

  Future<NotificationListModel?> getUserNotificationsList(
      {required String lang});

  // Future<PostModel> getSavedPostApi({required Map<String, dynamic> params});
}
