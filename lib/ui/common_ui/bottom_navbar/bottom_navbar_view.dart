import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/page1.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
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
    // const Page1(),
    const ForumView(),
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
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: S.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined),
            label: S.of(context)!.healthMix,
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.menu_book_outlined),
            icon: Icon(Icons.group),
            // label: 'Secret Diary',
            label: S.of(context)!.forum,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: S.of(context)!.profile,
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
