import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/viewModel/ai_chatbot_viewmodel.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/monthly_reminders_view_model.dart';
import 'package:provider/provider.dart';

import '../../generated/i18n.dart';
import '../../services/index.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';
import '../../utils/global_variables.dart';
import '../common_ui/bottom_navbar/bottom_navbar_view_model.dart';
import '../common_ui/forgot_password/forgot_psswrd_view_model.dart';
import '../common_ui/otp/otp_view_model.dart';
import '../common_ui/select_options/select_option_view_model.dart';
import '../common_ui/signup/signup_view_model.dart';
import '../common_ui/singin/signin_view_model.dart';
import '../common_ui/splash/splash_view_vdo.dart';
import '../common_ui/splash/splash_view_model.dart';
import '../common_ui/state_and_language_selection/state_selection_view_model.dart';
import '../common_ui/welcome/welcome_view_model.dart';
import '../naveli_ui/cycle_info/cycle_info_view_model.dart';
import '../naveli_ui/forum/forum_full_post/forum_full_post_view_model.dart';
import '../naveli_ui/forum/forum_view_model.dart';
import '../naveli_ui/forum/interest/interest_view_model.dart';
import '../naveli_ui/health_mix/health_mix_view_model.dart';
import '../naveli_ui/home/all_about_periods/all_about_periods_view_model.dart';
import '../naveli_ui/home/ask_your_question/ask_your_question_view_model.dart';
import '../naveli_ui/home/ask_your_question/question_of_the_day/question_of_the_day_view_model.dart';
import '../naveli_ui/home/home_view_model.dart';
import '../naveli_ui/home/log_your_symptoms/log_your_symptoms_view_model.dart';
import '../naveli_ui/home/quiz/quiz_question/quiz_question_view_model.dart';
import '../naveli_ui/home/quiz/quiz_view_model.dart';
import '../naveli_ui/home/track/ailments/ailments_view_model.dart';
import '../naveli_ui/home/track/bmi_calculator/bmi_calculator_view_model.dart';
import '../naveli_ui/home/track/medication/medication_view_model.dart';
import '../naveli_ui/home/track/sleep/sleep_view_model.dart';
import '../naveli_ui/home/track/water_reminder/water_reminder_view_model.dart';
import '../naveli_ui/home/track/weight/weight_view_model.dart';
import '../naveli_ui/home/women_in_news/women_in_news_view_model.dart';
import '../naveli_ui/home/you_know/all_posts_model.dart';
import '../naveli_ui/profile/about_us/about_us_view_model.dart';
import '../naveli_ui/profile/account_access/account_access_view_model.dart';
import '../naveli_ui/profile/dashboard/dashboard_view_model.dart';
import '../naveli_ui/profile/reports/reports_view_model.dart';
import '../naveli_ui/profile/your_naveli/your_naveli_view_model.dart';
import '../naveli_ui/secret_diary/more/more_view_model.dart';
import '../naveli_ui/secret_diary/particular_date_details/particular_date_details_view_model.dart';
import '../naveli_ui/secret_diary/reflections/reflections_view_model.dart';
import '../naveli_ui/secret_diary/secret_diary_view_model.dart';
import '../naveli_ui/secret_diary/set_reminder/set_reminder_view_model.dart';
import 'app_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  final _app = AppModel();
  StreamSubscription<ConnectivityResult>? subscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    initConnectivity();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final appModel = Provider.of<AppModel>(context, listen: false);
        appModel.attachedContext(context);
        appModel.changeLanguage(); // Ensure language is applied
      } catch (e) {
        debugPrint("Error accessing Provider<AppModel>: $e");
      }
    });

    Services().configAPI();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return checkConnectivity(result);
  }

  Future<void> checkConnectivity(ConnectivityResult result) async {
    _app.connectionStatus = result;
    if (_app.connectionStatus == ConnectivityResult.wifi ||
        _app.connectionStatus == ConnectivityResult.mobile ||
        _app.connectionStatus == ConnectivityResult.bluetooth ||
        _app.connectionStatus == ConnectivityResult.vpn) {
      connectivity = true;
    } else {
      connectivity = false;
    }
    // log("InternetChanges :: ${_app.connectionStatus}");
    if (isNotifyConnectivity) {
      CommonUtils.showSnackBar(
        connectivity
            ? S.of(mainNavKey.currentContext!)!.online
            : S.of(mainNavKey.currentContext!)!.offline,
        color: connectivity ? CommonColors.greenColor : CommonColors.mRed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>(create: (_) => AppModel()),
        ChangeNotifierProvider<SplashViewModel>(
            create: (_) => SplashViewModel()),
        ChangeNotifierProvider<SignupViewModel>(
            create: (_) => SignupViewModel()),
        ChangeNotifierProvider<SignInViewModel>(
            create: (_) => SignInViewModel()),
        ChangeNotifierProvider<ForgotPsswrdViewModel>(
            create: (_) => ForgotPsswrdViewModel()),
        ChangeNotifierProvider<OTPViewModel>(create: (_) => OTPViewModel()),
        ChangeNotifierProvider<WelcomeViewModel>(
            create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider<BottomNavbarViewModel>(
            create: (_) => BottomNavbarViewModel()),
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<WeightViewModel>(
            create: (_) => WeightViewModel()),
        ChangeNotifierProvider<SelectOptionViewModel>(
            create: (_) => SelectOptionViewModel()),
        ChangeNotifierProvider<SecretDiaryViewModel>(
            create: (_) => SecretDiaryViewModel()),
        ChangeNotifierProvider<MonthlyRemindersViewModel>(
            create: (_) => MonthlyRemindersViewModel()),
        ChangeNotifierProvider<CycleInfoViewModel>(
            create: (_) => CycleInfoViewModel()),
        ChangeNotifierProvider<LogYourSymptomsModel>(
            create: (_) => LogYourSymptomsModel()),
        ChangeNotifierProvider<MedicationViewModel>(
            create: (_) => MedicationViewModel()),
        ChangeNotifierProvider<AilmentsViewModel>(
            create: (_) => AilmentsViewModel()),
        ChangeNotifierProvider<BmiCalculatorViewModel>(
            create: (_) => BmiCalculatorViewModel()),
        ChangeNotifierProvider<AllPostsModel>(create: (_) => AllPostsModel()),
        ChangeNotifierProvider<HealthMixViewModel>(
            create: (_) => HealthMixViewModel()),
        ChangeNotifierProvider<ParticularDateDetailsViewModel>(
            create: (_) => ParticularDateDetailsViewModel()),
        ChangeNotifierProvider<QuizViewModel>(create: (_) => QuizViewModel()),
        ChangeNotifierProvider<QuizQuestionViewModel>(
            create: (_) => QuizQuestionViewModel()),
        ChangeNotifierProvider<QuestionOfDayViewModel>(
            create: (_) => QuestionOfDayViewModel()),
        ChangeNotifierProvider<AskYourQuestionViewModel>(
            create: (_) => AskYourQuestionViewModel()),
        ChangeNotifierProvider<WomenInNewsViewModel>(
            create: (_) => WomenInNewsViewModel()),
        ChangeNotifierProvider<ForumViewModel>(create: (_) => ForumViewModel()),
        ChangeNotifierProvider<ForumFullPostViewModel>(
            create: (_) => ForumFullPostViewModel()),
        ChangeNotifierProvider<InterestViewModel>(
            create: (_) => InterestViewModel()),
        ChangeNotifierProvider<WaterReminderViewModel>(
            create: (_) => WaterReminderViewModel()),
        ChangeNotifierProvider<SleepViewModel>(create: (_) => SleepViewModel()),
        ChangeNotifierProvider<AllAboutPeriodsViewModel>(
            create: (_) => AllAboutPeriodsViewModel()),
        ChangeNotifierProvider<StateSelectionViewModel>(
            create: (_) => StateSelectionViewModel()),
        ChangeNotifierProvider<AboutUsViewModel>(
            create: (_) => AboutUsViewModel()),
        ChangeNotifierProvider<MoreViewModel>(create: (_) => MoreViewModel()),
        ChangeNotifierProvider<DashBoardViewModel>(
            create: (_) => DashBoardViewModel()),
        ChangeNotifierProvider<ReflectionsViewModel>(
            create: (_) => ReflectionsViewModel()),
        ChangeNotifierProvider<SetReminderViewModel>(
            create: (_) => SetReminderViewModel()),
        ChangeNotifierProvider<AccountAccessViewModel>(
            create: (_) => AccountAccessViewModel()),
        ChangeNotifierProvider<YourNaveliViewModel>(
            create: (_) => YourNaveliViewModel()),
        ChangeNotifierProvider<ReportsViewModel>(
            create: (_) => ReportsViewModel()),
        ChangeNotifierProvider(create: (_) => AiChatBotViewModel()),
      ],
      child: Consumer<AppModel>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          color: CommonColors.primaryColor,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          navigatorKey: mainNavKey,
          theme: ThemeData(
            useMaterial3: true,
            // scaffoldBackgroundColor: CommonColors.bgColor,
            // primaryColor: CommonColors.primaryColor,
            // fontFamily: AppConstants.OUTFIT_FONT,
            // colorScheme: const ColorScheme.light(
            //   primary: CommonColors.primaryColor,
            //   secondary: CommonColors.secondaryColor,
            // ),
            appBarTheme: const AppBarTheme(
              // backgroundColor: CommonColors.bgColor,
              // foregroundColor: CommonColors.bgColor,
              surfaceTintColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: CommonColors.primaryColor,
              ),
              scrolledUnderElevation: 0,
              // titleTextStyle: getAppStyle(
              //   fontSize: 20,
              //   fontWeight: FontWeight.w600,
              //   color: CommonColors.primaryColor,
              // ),
            ),
            // menuTheme: MenuThemeData(
            //   style: MenuStyle(
            //     surfaceTintColor:
            //     const MaterialStatePropertyAll(CommonColors.mWhite),
            //     shape: MaterialStatePropertyAll(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     elevation: const MaterialStatePropertyAll(20),
            //   ),
            // ),
            // progressIndicatorTheme: const ProgressIndicatorThemeData(
            //   color: CommonColors.primaryColor,
            //   linearMinHeight: 2,
            // ),
            // bottomSheetTheme: const BottomSheetThemeData(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(15),
            //       topRight: Radius.circular(15),
            //     ),
            //   ),
            // ),
            // dialogBackgroundColor: CommonColors.mWhite,
            // drawerTheme: const DrawerThemeData(
            //   surfaceTintColor: CommonColors.mWhite,
            //   backgroundColor: CommonColors.mWhite,
            // ),
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: CommonColors.primaryColor,
            //     foregroundColor: CommonColors.mWhite,
            //   ),
            // ),
            // listTileTheme: ListTileThemeData(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            // ),
            // inputDecorationTheme: InputDecorationTheme(
            //   contentPadding: const EdgeInsets.all(0),
            //   border: InputBorder.none,
            //   enabledBorder: InputBorder.none,
            //   focusedBorder: InputBorder.none,
            //   hintStyle: getAppStyle(
            //     color: CommonColors.mGrey,
            //   ),
            // ),
          ),
          locale: Locale(Provider.of<AppModel>(context).locale, ""),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeListResolutionCallback: S.delegate.listResolution(
              fallback: const Locale(AppConstants.LANGUAGE_ENGLISH, '')),
          home: const SplashViewVdo(),
        ),
      ),
    );
  }
}
