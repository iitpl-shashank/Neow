import 'package:flutter/cupertino.dart';

class SelectOptionViewModel with ChangeNotifier {
  late BuildContext context;
  int selectedIndex = 1;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
