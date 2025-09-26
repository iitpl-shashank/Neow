import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/global_variables.dart';
import '../../naveli_ui/forum/forum_view.dart';
import '../../naveli_ui/health_mix/health_mix_view.dart';
import '../../naveli_ui/home/home_view.dart';
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
  String dateString = globalUserMaster?.previousPeriodsBegin ?? '';

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    mViewModel = Provider.of<BottomNavbarViewModel>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarViewModel>(
      builder: (context, viewModel, child) {
        final pages = [
          const HomeView(),
          HealthMixView(
            title: S.of(context)!.healthMix,
          ),
           ForumView(),
          const ProfileView(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: S.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.volunteer_activism_outlined),
                label: S.of(context)!.healthMix,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: S.of(context)!.forum,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                label: S.of(context)!.profile,
              ),
            ],
            currentIndex: viewModel.selectedIndex,
            selectedItemColor: CommonColors.primaryColor,
            unselectedItemColor: Colors.grey[600],
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: viewModel.onMenuTapped,
          ),
        );
      },
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
