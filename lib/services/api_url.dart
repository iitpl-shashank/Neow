class ApiUrl {
  // Local
  // static const String BASE_URL = "http://192.168.1.95/new_naveli/api/";

  // Live
  // static const String BASE_URL = "https://new-naveli.harmistechnology.com/api/";
  static const String BASE_URL = "https://neowindia.com/api/";
  // static const String BASE_URL = "https://naveli.smartscan.in/api/";

  static const String SIGN_UP = "${BASE_URL}signup";
  static const String LOGIN = "${BASE_URL}login";
  static const String DynamicText = "${BASE_URL}get-dyanamic-text";
  static const String logSymptoms = "${BASE_URL}listuserSymptomsLogs";
  static const String VERIFY_MOBILE = "${BASE_URL}verify-mobile";
  static const String USER_DETAIL = "${BASE_URL}user-details";
  static const String LOGOUT = "${BASE_URL}logout";
  static const String USER_UPDATE_DETAILS = "${BASE_URL}user-update-details";
  static const String USER_UPDATE_DASHBOARD = "${BASE_URL}updateUserDashboard";
  static const String USER_SYMPTOMS_LOG = "${BASE_URL}storeUserSymptomsLogs";
  static const String GET_USER_SYMPTOMS_LOG = "${BASE_URL}listuserSymptomsLogs";
  static const String GET_MEDICINE_LIST = "${BASE_URL}medicineList";
  static const String GET_AILMENTS_LIST = "${BASE_URL}ailmentsList";
  static const String GET_ALL_POSTS = "${BASE_URL}get-all-posts";
  static const String GET_HEALTH_MIX_POSTS = "${BASE_URL}healthMixPostList";
  static const String GET_QUIZ_QUESTION = "${BASE_URL}questionlist";
  static const String GET_ADMIN_ANSWER = "${BASE_URL}adminAnswer";
  static const String GET_WOMEN_NEWS = "${BASE_URL}newsDetails";
  static const String GET_FORUM_POST = "${BASE_URL}forumsList";
  static const String GET_ALL_ABOUT_PERIODS_LIST =
      "${BASE_URL}getAllAboutPeriodsList";
  static const String GET_FESTIVAL = "${BASE_URL}FestivalList";
  static const String GET_STATE = "${BASE_URL}stateList";
  static const String GET_CITY = "${BASE_URL}cityList";
  static const String STORE_CITY = "${BASE_URL}storeCity";
  static const String STORE_STATE = "${BASE_URL}storeState";
  static const String GET_DAILY_DIARY = "${BASE_URL}getDailyDiary";
  static const String GET_SUB_QUESTION = "${BASE_URL}sub-questions-list";
  static const String STORE_DAILY_DIARY = "${BASE_URL}StoreDailydairy";
  static const String STORE_HIRSUTISM = "${BASE_URL}user-hirsutism/store";
  static const String GET_LIKED_POST = "${BASE_URL}getUserLikesOrDislikes";
  static const String STORE_MONTHLY_MISSION = "${BASE_URL}monthlymission";
  static const String VERIFY_UNIQUE_ID = "${BASE_URL}verifyUniqueId";
  static const String GET_DATA_FROM_UNIQUE_ID = "${BASE_URL}fatchUserDataOnUid";
  static const String VERIFY_ACCOUNT_STATUS =
      "${BASE_URL}naveliResponseToBuddy";
  static const String STORE_MONTHLY_REMINDER =
      "${BASE_URL}storeUserMonthlyReminder";
  static const String STORE_SUB_QUESTION_ANSWER =
      "${BASE_URL}subQuestionAnswer";
  static const String GET_QUESTION_ANSWER = "${BASE_URL}question-answers";
  static const String STORE_QUESTION_ANSWER = "${BASE_URL}question-answer";
  static const String GET_FORUM_COMMENT = "${BASE_URL}getUsersCommentList";
  static const String STORE_FORUM_COMMENT = "${BASE_URL}forumCommentStore";
  static const String GET_SLIDER_VIDEO = "${BASE_URL}getHomePage";
  static const String GET_ABOUT_US = "${BASE_URL}getAboutAndDescription";
  static const String GET_MONYHLY_MISSION = "${BASE_URL}getMonthlyMisssion";
  static const String GET_REFLECTION = "${BASE_URL}getReflectionData";
  static const String GET_BUDDY_REQUEST = "${BASE_URL}getBuddiesRequest";
  static const String DOWNLOAD_REPORT_PDF = "${BASE_URL}downloadUserDataPdf";
  static const String USER_SYMPTOMS_SCORE = "${BASE_URL}listuserSymptomsLogs";
  static const String CHECK_DEVICE_TOKEN = "${BASE_URL}checkDeviceToken";
  static const String REMOVE_DEVICE_TOKEN =
      "${BASE_URL}removeExistingDeviceToken";
  static const String GET_MONTHLY_REMINDER =
      "${BASE_URL}getStoredUserMonthlyReminder";
  static const String GET_BUDDY_SENDED_REQUEST =
      "${BASE_URL}getSendingAccessRequests";
  static const String STORE_HEALTHMIX_LIKE =
      "${BASE_URL}userHealthMixLikeDislike";
  static const String STORE_USER_MEDICATION =
      "${BASE_URL}track/storeUserMedicationsDetail";
  static const String STORE_USER_AILMENTS =
      "${BASE_URL}track/storeUserAilmentsDetail";
  static const String GET_STORED_USER_MEDICATION =
      "${BASE_URL}track/getStoredMedicationsDetail";
  static const String GET_STORED_USER_AILMENTS =
      "${BASE_URL}track/getStoredAilmentsDetail";
  static const String STORE_USER_BMI =
      "${BASE_URL}track/storeBmiCalculatorDetail";
  static const String STORE_USER_WEIGHT = "${BASE_URL}track/storeWeightDetail";
  static const String GET_QUIZ_CATEGORY = "${BASE_URL}questionType";
  static const String STORE_QUESTION_OF_DAY = "${BASE_URL}userQuestionStore";
  static const String GET_DETAILS_ALL_PERIOD =
      "${BASE_URL}getDetailOfAllAboutPeriod";
  static const String STORE_WATER_DETAIL =
      "${BASE_URL}track/storeUserWaterReminders";
  static const String GET_STORED_SLEEP_DETAILS =
      "${BASE_URL}track/getStoredUserSleepDetail";
  static const String STORE_SLEEP_DETAIL =
      "${BASE_URL}track/storeUserSleepDetail";
  static const String GET_WEIGHT_DETAIL =
      "${BASE_URL}track/getStoredWeightDetail";
  static const String GET_BMI_DETAIL =
      "${BASE_URL}track/getStoredBmiCalculatorDetail";
  static const String GET_WATER_DETAIL =
      "${BASE_URL}track/getStoredUserWaterReminders";
  static const String GET_MONTHLY_REMINDERS = "${BASE_URL}getMonthlyReminder";
  static const String ADD_MONTHLY_REMINDERS =
      "${BASE_URL}storeUserMonthlyReminder";
  static const String GET_PERIOD_INFO = "${BASE_URL}getPeriodInfo";
  static const String ADD_PERIOD_INFO = "${BASE_URL}savePeriodsInfo";
  static const String GET_ABOUT_YOUR_CYCLE = "${BASE_URL}aboutYourCycle";
  static const String notification = "${BASE_URL}notification";
  static const String getHealthMixCategoryList =
      "${BASE_URL}healthMixCategoryList";
  static const String getHealthMixLatestVideoList = "${BASE_URL}healthMixList";
  static const String getVaccinationDetails = "${BASE_URL}vaccination-details";
  static const String vaccinationUpdateDetails =
      "${BASE_URL}vaccination-update-details";
  static const String getUserSymptomsReport =
      "${BASE_URL}userReportSymptomsLogs";
}
