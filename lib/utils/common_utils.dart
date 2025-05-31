import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/i18n.dart';
import 'common_colors.dart';
import 'constant.dart';
import 'global_variables.dart';

class Screen {
  static double height() {
    return MediaQuery.of(mainNavKey.currentContext!).size.height;
  }

  static double width() {
    return MediaQuery.of(mainNavKey.currentContext!).size.width;
  }

  static EdgeInsets viewPadding() {
    return MediaQuery.of(mainNavKey.currentContext!).viewPadding;
  }
}

Future<void> push(Widget screen) async {
  await Navigator.push(
      mainNavKey.currentContext!,
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          : CupertinoPageRoute(builder: (context) {
              return screen;
            }));
}

void pushAndRemoveUntil(Widget screen) async {
  Navigator.pushAndRemoveUntil(
      mainNavKey.currentContext!,
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          : CupertinoPageRoute(builder: (context) {
              return screen;
            }),
      (route) => false);
}

void pushReplacement(Widget screen) async {
  Navigator.pushReplacement(
      mainNavKey.currentContext!,
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) {
              return screen;
            })
          : CupertinoPageRoute(
              builder: (context) {
                return screen;
              },
            ));
}

String getFormattedDate(DateTime dateTime, format) {
  try {
    //final DateFormat formatter = DateFormat('d MMM y, HH:mm');
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
  }
  return "";
}

String getFormattedDateBookingAsset(DateTime dateTime) {
  try {
    log("Date $dateTime");
    //  final DateFormat formatter = DateFormat('d MMM y, HH:mm');
    final DateFormat formatter = DateFormat('MMM d');
    final String formatted = formatter.format(dateTime);
    log("Format Date $formatted");
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getFormattedTimeBooking(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
  }
  return "";
}

String getSelectedDateFormat(DateTime dateTime) {
  try {
    final DateFormat formatter =
        DateFormat("MMM d'${getDayOfMonthSuffix(dateTime.day)}' yyyy");
    final String formatted = formatter.format(dateTime);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-- -- --";
  }
}

String getFormattedDateNew(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('d MMM y HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getNotificationFormattedDate(DateTime dateTime) {
  try {
    final DateFormat formatter = DateFormat('d MMM, HH:mm');
    final String formatted = formatter.format(dateTime);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getUpcomingFormattedDate(DateTime fromDate, DateTime toDate) {
  try {
    final DateFormat formatter = DateFormat('MMM d, y');
    final String formatted =
        "${formatter.format(fromDate)} - ${formatter.format(toDate)}";
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getFormattedDateBooking(DateTime fromDate) {
  try {
    final DateFormat formatter = DateFormat('d MMMM y');
    final String formatted = formatter.format(fromDate);
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "-";
  }
}

String getUpcomingFormattedTime(DateTime fromDate, DateTime toDate) {
  try {
    final DateFormat timeFormatter = DateFormat('hh:mm aa');
    final String formatted =
        "${timeFormatter.format(fromDate)} - ${timeFormatter.format(toDate)}";
    log(formatted);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "";
  }
}

String getFormattedTime(DateTime fromDate) {
  try {
    final DateFormat timeFormatter = DateFormat('hh:mm aa');
    final String formatted = timeFormatter.format(fromDate);
    return formatted;
  } catch (e) {
    log("error: ${e.toString()}");
    return "";
  }
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

launchURL(String url) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } on Exception catch (e) {
    log('[CommonUtils] Launch url exception : ${e.toString()}');
  }
}

launchFBURL({String? appUrl, String? webUrl}) async {
  Uri fbProtocolUrl;
  if (Platform.isIOS) {
    appUrl!.replaceAll("page", "profile");
    log('Apple Url : ${appUrl.replaceAll("page", "profile")}');
    fbProtocolUrl = Uri.parse(appUrl);
  } else {
    fbProtocolUrl = Uri.parse(appUrl!);
  }

  Uri url = Uri.parse(webUrl!);

  try {
    bool launched = await launchUrl(fbProtocolUrl);
    if (!launched) {
      log('message web url launch call');
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

double getCurrentPositionFromKey(key) {
  RenderBox box = key.currentContext.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  double y = position.dy;
  return y;
}

int calculateMonthSize(DateTime dateTime) {
  return dateTime.year * 12 + dateTime.month;
}

int getMonthSizeBetweenDates(String initialDate, String endDate) {
  return calculateMonthSize(DateTime.parse(endDate)) -
      calculateMonthSize(DateTime.parse(initialDate)) +
      1;
}

void showProgressDialog() {
  EasyLoading.show();
}

void dismissProgressDialog() {
  EasyLoading.dismiss();
}

ImageProvider getImageProvider({String? imagePath}) {
  if (imagePath!.startsWith("http")) {
    return NetworkImage(imagePath);
  } else if (imagePath.startsWith("assets")) {
    return AssetImage(imagePath);
  } else {
    return FileImage(File(imagePath));
  }
}

final defaultPinTheme = PinTheme(
  width: 42,
  height: 42,
  textStyle: getAppStyle(
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: CommonColors.primaryColor,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: CommonColors.primaryColor,
    ),
  ),
);

void showDatePickerDialog({TextEditingController? dateController}) async {
  final DateTime? selected = await showDatePicker(
    context: mainNavKey.currentContext!,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2030),
    keyboardType: TextInputType.text,
    builder: (BuildContext? context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: CommonColors.primaryColor,
          hintColor: CommonColors.primaryColor,
          colorScheme: const ColorScheme.light(
            primary: CommonColors.primaryColor,
          ),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
  if (selected != null && selected != dateController) {
    var formatter = DateFormat('yyyy-MM-dd');
    dateController!.text = formatter.format(selected);
    log("selectedDate ${dateController.text}");
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/* ----------------- below extension is use to remove duplicate object with same element ----------------- */
extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    for (var element in this) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    }
    return result;
  }
}

class CommonUtils {
  static bool isShowing = false;
  static bool isShowingDownload = false;
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static Function mathFunc = (Match match) => '${match[1]},';
  static String languageCode = "en";
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static late PackageInfo packageInfo;
  static Map<String, dynamic> deviceData = {};

  static bool isvalidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(email)) ? false : true;
  }

  static bool isValidPassword(String password) {
    String pattern = r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)";
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(password)) ? false : true;
  }

  static bool isvalidPhone(String phone) {
    return phone.length == 10 ? true : false;
  }

  static void showSnackBar(
    String? message, {
    String? title,
    Color? color,
  }) {
    if (!isShowingDownload) {
      ScaffoldMessenger.of(mainNavKey.currentContext!).showSnackBar(
        SnackBar(
          elevation: 0,
          content: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: CommonColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: getAppStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.all(5),
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  static void oopsMSG() {
    if (connectivity) {
      ScaffoldMessenger.of(mainNavKey.currentContext!).hideCurrentSnackBar();
      ScaffoldMessenger.of(mainNavKey.currentContext!).showSnackBar(
        SnackBar(
          elevation: 0,
          content: Text(
            S.of(mainNavKey.currentContext!)!.oops,
            textAlign: TextAlign.center,
            style: getAppStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          padding: const EdgeInsets.all(5),
          backgroundColor: const Color.fromARGB(255, 247, 117, 108),
        ),
      );
    }
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: CommonColors.mWhite,
      fontSize: 16.0,
    );
  }

  static void showGreenToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: CommonColors.greenColor,
      textColor: CommonColors.mWhite,
      fontSize: 16.0,
    );
  }

  static void showRedToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: CommonColors.mRed,
      textColor: CommonColors.mWhite,
      fontSize: 16.0,
    );
  }

  static hideKeyboard() {
    try {
      FocusScope.of(mainNavKey.currentContext!).unfocus();
    } catch (e) {
      log("Exception :: $e");
    }
  }

  static void showProgressDialog({from}) {
    isShowing = true;
    showCupertinoDialog(
      barrierDismissible: false,
      context: mainNavKey.currentContext!,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    ).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        hideProgressDialog();
        // Unneccessary network error toast here
        // oopsMSG();
        isShowing = false;
        print(
            "................................process dialog oops.............................");
      },
    );
  }

  static void hideProgressDialog() {
    if (isShowing) {
      debugPrint("Hiding progress dialog...");
      print("Hiding progress dialog...");
      Navigator.of(mainNavKey.currentContext!, rootNavigator: true)
          .pop('dialog');
      isShowing = false;
    }
  }

  static Widget getItemProgressBar({bool isCenter = true}) {
    const progressIndicator = CircularProgressIndicator(
      color: CommonColors.primaryColor,
      strokeWidth: 2,
    );
    return isCenter
        ? const Center(child: progressIndicator)
        : progressIndicator;
  }

  static Future<double> getImageFileInMb(File image) async {
    final bytes = await image.readAsBytes();
    final kb = bytes.length / 1024;
    final mb = kb / 1024;
    return mb;
  }

  /*static String currencyFormat(String number) {
    if (number == "0,00" || number == "0,0" || number == "0") {
      return S.of(mainNavigatorKey.currentContext!!).walletZero;
    }
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,###',
      symbol: '€',
      decimalDigits: 2,
    );
    return "€ ${currencyFormat.format(double.parse(number.replaceAll(",", ".")))}";
  }*/

  static String dateFormatyyyyMMDD(String dateStr) {
    try {
      return DateFormat('yyyy-MM-dd').format(DateTime.parse(dateStr));
    } on Exception catch (e) {
      log("Exception (dateFormatyyyyMMDD) :: $e");
      return dateStr;
    }
  }

  static bool isFutureDate(String stringDate) {
    try {
      return !DateTime.now().isAfter(DateTime.parse(stringDate));
    } on Exception catch (e) {
      log("date parsing failed :: $e");
      return false;
    }
  }

  static String getDateFormatForDetails(String dateStr) {
    try {
      return DateFormat('EEEE d MMM y', 'it_IT')
          .format(DateTime.parse(dateStr));
    } on Exception catch (e) {
      log("Exception (getDateFormatForDetails) :: $e");
      return dateStr;
    }
  }

  static String getDifference({String? startDate, String? endDate}) {
    final DateTime start = DateTime.parse(startDate!);
    final DateTime end = DateTime.parse(endDate!);

    Duration diff = end.difference(start);
    int diffmonths = diff.inDays ~/ 30;

    return diffmonths.toString();
  }

  static String getDifferenceFromNow({String? endDate}) {
    final DateTime start = DateTime.now();
    final DateTime end = DateTime.parse(endDate!);

    Duration diff = end.difference(start);
    int diffmonths = diff.inDays ~/ 30;

    return diffmonths.toString();
  }

  static Color getAlertColor(String color) {
    switch (color) {
      case 'yellow':
        return Colors.yellow.withOpacity(0.2);
      case 'red':
        return Colors.red.withOpacity(0.2);
      case 'green':
        return Colors.green.withOpacity(0.2);
      default:
        return Colors.green.withOpacity(0.2);
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void makePhoneCall(String phone) async {
    if (phone.isNotEmpty) {
      String url = "tel:$phone";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw S.of(mainNavKey.currentContext!)!.dataNotFound;
      }
    } else {
      CommonUtils.showSnackBar(
        S.of(mainNavKey.currentContext!)!.contactNoNotAvailable,
        color: CommonColors.mRed,
      );
    }
  }

  static String getTimeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  static Future<bool> handleLocationPermission() async {
    while (!await Geolocator.isLocationServiceEnabled()) {
      await openPermissionDialog(
        Icons.location_on,
        S.of(mainNavKey.currentContext!)!.locationService,
        S.of(mainNavKey.currentContext!)!.plEnableLocationService,
        S.of(mainNavKey.currentContext!)!.enableService,
        () async {
          await Geolocator.openLocationSettings();
        },
      );
    }

    while (LocationPermission.deniedForever ==
            await Geolocator.checkPermission() ||
        LocationPermission.denied == await Geolocator.checkPermission()) {
      await openPermissionDialog(
        Icons.my_location,
        S.of(mainNavKey.currentContext!)!.locationPermission,
        S.of(mainNavKey.currentContext!)!.plAllowLocationPermission,
        S.of(mainNavKey.currentContext!)!.allowPermission,
        () async {
          await Geolocator.openAppSettings();
        },
      );
    }

    // bool serviceEnabled;
    // LocationPermission permission;
    //
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //   CommonUtils.showSnackBar(
    //     "Location services are disabled. Please enable the services",
    //     color: Colors.red,
    //   );
    //   Geolocator.openLocationSettings();
    //   return false;
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     CommonUtils.showSnackBar("Location permissions are denied",
    //         color: Colors.red);
    //     Geolocator.openAppSettings();
    //     return false;
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   Geolocator.openAppSettings();
    //   CommonUtils.showSnackBar(
    //     "Location permissions are permanently denied, we cannot request permissions.",
    //     color: Colors.red,
    //   );
    //   return false;
    // }
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    // final hasPermission = await handleLocationPermission();
    // if (!hasPermission) return null;
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // static Future<bool> isDeviceSupportBiomatric() async {
  //   LocalAuthentication auth = LocalAuthentication();
  //   final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  //   final bool canAuthenticate =
  //       canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  //   if (canAuthenticate) {
  //     List<BiometricType> availableBiometrics =
  //         await auth.getAvailableBiometrics();
  //     if (availableBiometrics.isNotEmpty) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     return false;
  //   }
  // }

  static popUpMenu({Function()? onTap, String? text}) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            onTap: onTap,
            child: Text(text!),
          ),
        ];
      },
    );
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static void shareApp({String? link}) {
    final appLink = link ??
        "https://play.google.com/store/apps/details?id=com.naveli.naveli_2023";
    Share.share(
      "Check out the Neow app!\n$appLink",
      subject: "Neow App",
    );
  }
}

// void imagePickerOption(
//     {required Function()? onTapCamera, required Function()? onTapPhotos}) {
//   showModalBottomSheet(
//     context: mainNavigatorKey.currentContext!,
//     clipBehavior: Clip.antiAlias,
//     builder: (context) {
//       return Padding(
//         padding: kCommonAllBottomPadding,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(
//                 Icons.camera,
//                 size: 25,
//               ),
//               title: Text(
//                 S.of(context)!.camera,
//                 style: getAppStyle(),
//               ),
//               onTap: onTapCamera,
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.photo,
//                 size: 25,
//               ),
//               title: Text(
//                 S.of(context)!.gallery,
//                 style: getAppStyle(),
//               ),
//               onTap: onTapPhotos,
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

Future<File> openCamera() async {
  final XFile? selectedImages = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 70,
  );
  if (selectedImages != null) {
    return File(selectedImages.path);
  } else {
    return File('');
  }
}

Future<File?> pickSinglePhoto() async {
  File? image;
  final XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (selectedImage != null) {
    image = File(selectedImage.path);
    // if (isSquare || isEdit) {
    //   image = await cropImage(selectedImage.path, isSquare: isSquare);
    // }
  }
  return image;
}

Future<void> share(String? link, {String? text}) async {
  if (link == null || link.isEmpty) {
    CommonUtils.showRedToastMessage("Link is unavailable or invalid");
  } else {
    await Share.share(link);
  }
}

Future<void> shareNetworkImage(String? image, {String? text}) async {
  if (image == null || image.isEmpty) return;
  try {
    // CommonUtils.showToastMessage("Preparing image to share...");
    CommonUtils.showProgressDialog();
    Response response = await get(Uri.parse(image));
    Uint8List imageData = response.bodyBytes;
    String imagePath = await saveImageToFile(imageData);
    // CommonUtils.showToastMessage("Image ready for sharing");
    CommonUtils.hideProgressDialog();
    Share.shareXFiles(
      [XFile(imagePath)],
      text: text ?? 'Check out this awesome image!',
    );
  } catch (e) {
    CommonUtils.hideProgressDialog();
    log("Error fetching image: $e");
    CommonUtils.showSnackBar("Error fetching image");
  }
}

Future<String> saveImageToFile(Uint8List imageData) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  String imagePath = '$tempPath/temp_image.png';
  File imageFile = File(imagePath);
  await imageFile.writeAsBytes(imageData);
  return imagePath;
}

Future<List<File>> pickMultiplePhotos() async {
  List<File> images = [];
  final List<XFile> selectedImages = await ImagePicker().pickMultiImage(
    imageQuality: 70,
  );

  if (selectedImages.isEmpty) {
    return images;
  }

  for (var element in selectedImages) {
    images.add(File(element.path));
  }
  return images;
}

Future<void> openPermissionDialog(
  IconData icon,
  String dialogTitle,
  String alertMsg,
  String buttonLabel,
  void Function()? onPressBtn,
) async {
  await showDialog<void>(
    context: mainNavKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(
          icon,
          // Icons.location_on,
          color: CommonColors.primaryColor,
        ),
        title: Text(
          dialogTitle,
          // S.of(context)!.locationService,
          style: getAppStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  alertMsg,
                  style: getAppStyle(),
                ),
                kCommonSpaceV15,
              ],
            );
          },
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.mRed,
            ),
            child: Text(
              S.of(mainNavKey.currentContext!)!.done,
              style: getAppStyle(
                color: CommonColors.mWhite,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressBtn,
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.mRed,
            ),
            child: Text(
              buttonLabel,
              style: getAppStyle(
                color: CommonColors.mWhite,
              ),
            ),
          ),
        ],
      );
    },
  );
}

bool isCurrentDate(DateTime date) {
  final DateTime now = DateTime.now();
  return date.isAtSameMomentAs(DateTime(now.year, now.month, now.day));
}

/// Checks if the given date is a highlighted date.
bool isHighlightedDate(DateTime date, List<DateTime> highlightedDates) {
  return highlightedDates.any((DateTime highlightedDate) =>
      date.isAtSameMomentAs(DateTime(
          highlightedDate.year, highlightedDate.month, highlightedDate.day)));
}

/// Gets the number of days for the given month,
/// by taking the next month on day 0 and getting the number of days.
int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear
      ? DateTime(year, month + 1, 0).day
      : DateTime(year + 1, 1, 0).day;
}

/// Gets the name of the given month by its number,
/// using either the supplied or default name.
String getMonthName(int month) {
  final List<String> names = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return names[month - 1];
}

String getWeakName(int weak) {
  final List<String> weakNames = <String>[
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Su',
  ];
  return weakNames[weak - 1];
}
