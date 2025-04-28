import 'package:flutter/cupertino.dart';

class BottomNavbarViewModel with ChangeNotifier {
  late BuildContext context;
  int selectedIndex = 0;

  List<DateTime> getHighlightedDates() {
    return List<DateTime>.generate(
      10,
      (int index) => DateTime.now().add(Duration(days: 10 * (index + 1))),
    );
  }

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void onMenuTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
