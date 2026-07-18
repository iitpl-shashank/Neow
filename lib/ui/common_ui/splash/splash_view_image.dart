import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import '../../naveli_ui/profile/your_naveli/your_naveli_view_model.dart';
import 'reel_scroll_view.dart';

class SplashViewImage extends StatefulWidget {
  const SplashViewImage({super.key});

  @override
  State<SplashViewImage> createState() => _SplashViewImageState();
}

class _SplashViewImageState extends State<SplashViewImage> {
  late SplashViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.checkIsFirstTime(
          mViewModel: Provider.of<YourNaveliViewModel>(context, listen: false));
    });
  }

  void _finishSplash() {
    AppPreferences.instance.setIsFirstTime(false);
    mViewModel.onFinishGIF();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);
    return AppPreferences.instance.getIsFirstTime()
        ? ReelScrollView(
            onFinish: _finishSplash,
            onSkip: _finishSplash,
          )
        : const WelComeGifView();
  }
}
