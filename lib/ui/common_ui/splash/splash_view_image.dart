import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/local_images.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import '../../naveli_ui/profile/your_naveli/your_naveli_view_model.dart';

class SplashViewImage extends StatefulWidget {
  const SplashViewImage({super.key});

  @override
  State<SplashViewImage> createState() => _SplashViewImageState();
}

class _SplashViewImageState extends State<SplashViewImage> {
  late SplashViewModel mViewModel;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _splashImages = [
    LocalImages.splash_1,
    LocalImages.splash_2,
    LocalImages.splash_3,
    LocalImages.splash_4,
  ];

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
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  // Image PageView Slider
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _splashImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _splashImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                  ),

                  // Top Right Skip Button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: _finishSplash,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          S.of(context)!.skip,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom Controls (Dots + Next Button)
                  Positioned(
                    bottom: 30,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page Indicators (Dots)
                        Row(
                          children: List.generate(
                            _splashImages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 6),
                              height: 8,
                              width: _currentIndex == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? CommonColors.primaryColor
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        // Next / Get Started Button
                        ElevatedButton(
                          onPressed: () {
                            if (_currentIndex < _splashImages.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _finishSplash();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            _currentIndex == _splashImages.length - 1
                                ? S.of(context)!.getStarted
                                : S.of(context)!.next,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const WelComeGifView();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
