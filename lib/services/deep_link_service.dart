// services/deep_link_service.dart
import 'dart:async';
import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view_model.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSub;
  bool isInitialized = false;

  Future<void> initialize() async {
    _appLinks = AppLinks();
    
    // Handle initial deep link
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        log('Got initial uri: $uri');
        await handleDeepLink(uri);
      }
    } catch (e) {
      log('Error getting initial URI: $e');
    }

    // Handle deep links while app is running
    _linkSub = _appLinks.uriLinkStream.listen(
      (Uri? uri) async {
        if (uri != null) {
          log('Got uri while app running: $uri');
          await handleDeepLink(uri);
        }
      },
      onError: (err) {
        log('Error handling deep links: $err');
      },
    );
    
    isInitialized = true;
  }

  Future<void> handleDeepLink(Uri uri) async {
    try {
      log('Handling deep link: $uri');
      await _storeDeepLinkInfo(uri);
      
      // If we have a valid context, process immediately
      if (mainNavKey.currentContext != null) {
        await processDeepLink(uri);
      }
    } catch (e, s) {
      log('Error handling deep link: $e\n$s');
    }
  }

  Future<void> _storeDeepLinkInfo(Uri uri) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_pending_deeplink', true);
    await prefs.setString('pending_deeplink_path', uri.toString());
  }

  Future<void> processDeepLink(Uri uri) async {
    final context = mainNavKey.currentContext;
    if (context == null) return;

    try {
      final bottomNavbarViewModel = Provider.of<BottomNavbarViewModel>(
        context, 
        listen: false
      );

      // Clear stored deep link
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_pending_deeplink', false);
      log('Processing deep link and Routing: $uri');
      bottomNavbarViewModel.onMenuTapped(2);
      // Navigate based on URI
      // if (uri.path.contains('/forum')) {
      //   bottomNavbarViewModel.onMenuTapped(2);
      // }
    } catch (e) {
      log('Error processing deep link: $e');
    }
  }

  void dispose() {
    _linkSub?.cancel();
  }
}