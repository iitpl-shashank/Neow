import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../database/app_preferences.dart';
import '../../utils/common_utils.dart';
import '../../utils/constant.dart';

class AppModel with ChangeNotifier {
  // bool darkTheme = false;
  late BuildContext context;
  String locale = AppConstants.LANGUAGE_ENGLISH;
  ConnectivityResult connectionStatus = ConnectivityResult.none;

  AppModel() {
    // Load saved language preference on initialization
    _loadLanguagePreference();
  }

  void _loadLanguagePreference() async {
    String savedLocale = AppPreferences.instance.getLanguageCode();
    if (savedLocale.isNotEmpty) {
      locale = savedLocale;
      CommonUtils.languageCode = locale;
      notifyListeners();
    }
  }

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void changeLanguage() async {
    String locale = AppPreferences.instance.getLanguageCode();
    if (locale.isEmpty) {
      AppPreferences.instance.setLanguageCode(this.locale);
      locale = this.locale;
      CommonUtils.languageCode = locale;
    }
    this.locale = locale;
    CommonUtils.languageCode = locale;
    notifyListeners();
  }
}
