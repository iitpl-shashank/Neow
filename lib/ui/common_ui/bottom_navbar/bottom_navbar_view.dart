// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:naveli_2023/ui/naveli_ui/calendar/calendar_view.dart';
// import 'package:naveli_2023/utils/common_utils.dart';
// import 'package:provider/provider.dart';
// import '../../../utils/common_colors.dart';
// import '../../../utils/global_variables.dart';
// import '../../../utils/local_images.dart';
// import '../../../widgets/common_appbar.dart';
// import '../../naveli_ui/forum/forum_view.dart';
// import '../../naveli_ui/health_mix/health_mix_view.dart';
// import '../../naveli_ui/home/home_view.dart';
// import '../../naveli_ui/home/period_information/periods_Information_view.dart';
// import '../../naveli_ui/profile/profile_view.dart';
// import '../../naveli_ui/secret_diary/secret_diary_view.dart';
// import 'bottom_navbar_view_model.dart';
//
// class BottomNavbarView extends StatefulWidget {
//   const BottomNavbarView({super.key});
//
//   @override
//   State<BottomNavbarView> createState() => _BottomNavbarViewState();
// }
//
// class _BottomNavbarViewState extends State<BottomNavbarView> {
//   late BottomNavbarViewModel mViewModel;
//
//   final pages = [
//     const HomeView(),
//     const HealthMixView(),
//      SecretDiaryView(),
//     const ForumView(),
//     const ProfileView(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     mViewModel = Provider.of<BottomNavbarViewModel>(context);
//     return Scaffold(
//       body: pages[mViewModel.selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 10,
//         unselectedFontSize: 10,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               LocalImages.icon_home,
//               height: 26,
//               color: mViewModel.selectedIndex == 0
//                   ? CommonColors.darkPink
//                   : CommonColors.primaryColor,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               LocalImages.icon_health_mix,
//               height: 28,
//               color: mViewModel.selectedIndex == 1
//                   ? CommonColors.darkPink
//                   : CommonColors.primaryColor,
//             ),
//             label: 'Health Mix',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               LocalImages.icon_secrat_diary,
//               height: 25,
//               color: mViewModel.selectedIndex == 2
//                   ? CommonColors.darkPink
//                   : CommonColors.primaryColor,
//             ),
//             label: 'Secret Diary',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               LocalImages.icon_forum,
//               height: 28,
//               color: mViewModel.selectedIndex == 3
//                   ? CommonColors.darkPink
//                   : CommonColors.primaryColor,
//             ),
//             label: 'Forum',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.account_circle_rounded,
//               size: 32,
//             ),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: mViewModel.selectedIndex,
//         selectedItemColor: CommonColors.darkPink,
//         unselectedIconTheme: const IconThemeData(color: CommonColors.primaryColor),
//         onTap: (int index) {
//           mViewModel.onMenuTapped(index);
//         },
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/page1.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/global_variables.dart';
import '../../naveli_ui/forum/forum_view.dart';
import '../../naveli_ui/health_mix/health_mix_view.dart';
import '../../naveli_ui/health_mix/health_mix_view_model.dart';
import '../../naveli_ui/home/home_view.dart';
import '../../naveli_ui/home/home_view_model.dart';
import '../../naveli_ui/profile/profile_view.dart';
import 'bottom_navbar_view_model.dart';
import 'package:flutter/services.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
  late BottomNavbarViewModel mViewModel;
  int _selectedIndex = 0;
  late Map<String, IconData> iconDataMap = {};
  String dateString = globalUserMaster?.previousPeriodsBegin ?? '';

  final pages = [
    const HomeView(),
    const HealthMixView(),
    const Page1(),
    const ProfileView(),
    const ForumView(),
  ];

  @override
  void initState() {
    super.initState();

    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    mViewModel = Provider.of<BottomNavbarViewModel>(context, listen: false);

    Future.delayed(
      Duration.zero,
      () {
        final mHomeViewModel =
            Provider.of<HomeViewModel>(context, listen: false);
        final mHealthMixViewModel =
            Provider.of<HealthMixViewModel>(context, listen: false);
        // mViewModel.attachedContext(context);
        mHomeViewModel.fetchHealthMixCategoryList();
        mHealthMixViewModel.getHealthMixLatestPosts();
        // Loading Issue
        // mViewModel.getDialogBox(context);

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          mHomeViewModel.getPeriodInfoList();

          // await handleFirstBloc();
          await mHomeViewModel.handleSecondBloc(dateString);
          // await handleThirdBloc();
          // print("diipppka1");
          //mViewModel.fetchData();
          // _setTimeout();
          mHomeViewModel.updateSelectedDate(DateTime.now());
        });
      },
    );
  }

  @override
  void dispose() {
    // Reset orientation to allow other screens to use their default orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  // Future<void> loadIcons() async {
  //   iconDataMap = {
  //     "Home": await getImageIcon(LocalImages.icon_home, size: 26),
  //     "Health Mix": await getImageIcon(LocalImages.icon_health_mix, size: 28),
  //     "Secret Diary":
  //         await getImageIcon(LocalImages.icon_secrat_diary, size: 25),
  //     "Forum": await getImageIcon(LocalImages.icon_forum, size: 28),
  //   };0
  //   setState(() {});
  // }

  // Future<IconData> getImageIcon(String imagePath, {double? size}) async {
  //   final ByteData data = await rootBundle.load(imagePath);
  //   final Uint8List bytes = data.buffer.asUint8List();
  //   final ui.Codec codec = await ui.instantiateImageCodec(bytes);
  //   final ui.FrameInfo frameInfo = await codec.getNextFrame();
  //   final ui.Image image = frameInfo.image;
  //   final ByteData? byteData =
  //       await image.toByteData(format: ui.ImageByteFormat.png);
  //   if (byteData != null) {
  //     final IconData iconData = IconData(
  //       byteData.buffer.asUint8List()[byteData.offsetInBytes],
  //       fontFamily: 'ImageIcon',
  //     );
  //     return iconData;
  //   } else {
  //     throw Exception('Failed to load image');
  //   }
  // }

  /* @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<BottomNavbarViewModel>(context);
    return Scaffold(
      body: pages[mViewModel.selectedIndex],
      bottomNavigationBar: MotionTabBar(
        tabIconSelectedSize: 30,
        tabIconSize: 25,
        tabBarHeight: 50,
        labels: [
          S.of(context)!.home,
          S.of(context)!.healthMix,
          S.of(context)!.secretDiary,
          S.of(context)!.profile,
        ],
        initialSelectedTab: S.of(context)!.home,
        tabIconColor: CommonColors.primaryColor,
        tabIconSelectedColor: CommonColors.mWhite,
        tabSelectedColor: CommonColors.darkPink,
        tabSize: 45,
        onTabItemSelected: (int index) {
          setState(() {
            mViewModel.selectedIndex = index;
          });
          // mViewModel.onMenuTapped(index);
        },
        icons: const [
          // iconDataMap["Home"]!,
          // iconDataMap["Health Mix"]!,
          // iconDataMap["Secret Diary"]!,
          // iconDataMap["Forum"]!,
          Icons.house,
          Icons.volunteer_activism_sharp,
          Icons.menu_book_sharp,
          Icons.account_circle_rounded,
        ],
        textStyle: const TextStyle(color: CommonColors.darkPink, fontSize: 10),
      ),
    );
  } */

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      mViewModel.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[mViewModel.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined),
            label: 'Health Mix',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.menu_book_outlined),
            icon: Icon(Icons.group),
            // label: 'Secret Diary',
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CommonColors.primaryColor,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
  // void dateRangePicker() async {
  //   String selectedDateRange = "";
  //   DateTimeRange? picked = await showDateRangePicker(
  //       context: mainNavKey.currentContext!,
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year + 5),
  //       initialDateRange: DateTimeRange(
  //         end: DateTime(DateTime.now().year, DateTime.now().month,
  //             DateTime.now().day + 13),
  //         start: DateTime.now(),
  //       ),
  //       builder: (context, child) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ConstrainedBox(
  //               constraints:
  //                   const BoxConstraints(maxWidth: 350, maxHeight: 600),
  //               child: child,
  //             )
  //           ],
  //         );
  //       });
  //
  //   if (picked != null) {
  //     selectedDateRange =
  //         "${picked.start.year}-${picked.start.month}-${picked.start.day} / ${picked.end.year}-${picked.end.month}-${picked.end.day}";
  //     setState(() {});
  //   }
  // }
}
