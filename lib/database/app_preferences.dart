import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_master.dart';

class AppPreferences {
/* -------------------------------------------- Preference Constants -------------------------------------------- */

  // Constants for Preference-Name
  final String keyLoginDetails = "KEY_LOGIN_DETAILS";
  final String keyLanguageCode = "KEY_LANGUAGE_CODE";
  final String keyDeviceToken = "KEY_DEVICE_TOKEN";
  final String keyAccessToken = "keyAccessToken";
  final String keyFCMToken = "keyFCMToken";
  final String keyBuddyAccess = "keyBuddyAccess";
  final String keyRefreshToken = "keyRefreshToken";
  final String keyUserDetails = "KEY_USER_DETAILS";
  final String keyIsFirstTime = "KEY_IS_FIRST_TIME";
  final String keyInterestFavourite = "keyInterestFavourite";

  static final AppPreferences instance = AppPreferences.internal();

  factory AppPreferences() => instance;

  static SharedPreferences? _pref;

  AppPreferences.internal();

  static Future<SharedPreferences> initPref() async {
    _pref = await SharedPreferences.getInstance();
    log("initAppPreferences called");
    return _pref!;
  }

  // Method to set isFirstTime value
  Future<bool> setBuddyAccess(bool value) async {
    return _pref!.setBool(keyBuddyAccess, value);
  }

  // Method to get isFirstTime value
  bool getBuddyAccess() {
    return _pref!.getBool(keyBuddyAccess) ?? false;
  }

  // Method to set isFirstTime value
  Future<bool> setIsFirstTime(bool value) async {
    return _pref!.setBool(keyIsFirstTime, value);
  }

  // Method to set setInterestFavourite value
  Future<void> setInterestFavourite(List<String> value) async {
    await _pref!.setStringList(keyInterestFavourite, value);
  }

  // Method to get setInterestFavourite value
  Future<List<String>?> getInterestFavourite() async {
    return _pref!.getStringList(keyInterestFavourite);
  }

  // Method to get isFirstTime value
  bool getIsFirstTime() {
    return _pref!.getBool(keyIsFirstTime) ?? true;
  }

  // Method to set auth token
  Future<bool> setAccessToken(String value) async {
    return _pref!.setString(keyAccessToken, value);
  }

  // Method to get auth token
  String getAccessToken() {
    return _pref!.getString(keyAccessToken) ?? "";
  }

  Future<bool> setFCMToken(String value) async {
    return _pref!.setString(keyFCMToken, value);
  }

  // Method to get FCM token
  String getFCMToken() {
    return _pref!.getString(keyFCMToken) ?? "";
  }

  // Method to set user details
  Future<bool> setUserDetails(String value) {
    return _pref!.setString(keyUserDetails, value);
  }

  // Method to get user details
  UserMaster? getUserDetails() {
    String? userDetails = _pref!.getString(keyUserDetails);
    if (userDetails != null && userDetails.isNotEmpty) {
      return UserMaster.fromJson(jsonDecode(userDetails));
    } else {
      return null;
    }
  }

  // Method to set refresh token
  Future<bool> setRefreshToken(String value) async {
    return _pref!.setString(keyRefreshToken, value);
  }

  // Method to get refresh token
  String getRefreshToken() {
    return _pref!.getString(keyRefreshToken) ?? "";
  }

  // Method to set language code
  Future<bool> setLanguageCode(String value) {
    return _pref!.setString(keyLanguageCode, value);
  }

  // Method to get Language code
  String getLanguageCode() {
    return _pref!.getString(keyLanguageCode) ?? "en";
  }

  // Method to set device token
  Future<bool> setDeviceToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyDeviceToken, value);
  }

  // Method to get device token
  Future<String> getDeviceToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyDeviceToken) ?? "";
  }

  Future<bool> clear() {
    return _pref!.clear();
  }
}
