import 'package:flutter/cupertino.dart';

import '../../../../database/app_preferences.dart';

class InterestViewModel with ChangeNotifier {
  late BuildContext context;
  List<String> selectedOptions = [];
  List<String> previousSelectedOptions = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> loadSelectedOptions() async {
    previousSelectedOptions = await AppPreferences.instance.getInterestFavourite() ?? [];
    selectedOptions = List.from(previousSelectedOptions);
    notifyListeners();
  }

  bool isFavoriteSelected(String title) {
    return selectedOptions.contains(title);
  }

  // bool isNotInterestedSelected(String title) {
  //   return !selectedOptions.contains(title);
  // }

  Future<void> addOption(String title) async {
    if (!selectedOptions.contains(title)) {
      selectedOptions.add(title);
      await AppPreferences.instance.setInterestFavourite(selectedOptions);
      notifyListeners();
    }
  }

  Future<void> removeOption(String title) async {
    if (selectedOptions.contains(title)) {
      selectedOptions.remove(title);
      await AppPreferences.instance.setInterestFavourite(selectedOptions);
      notifyListeners();
    }
  }

  Future<void> toggleOption(String title) async {
    if (selectedOptions.contains(title)) {
      await removeOption(title);
      loadSelectedOptions();
    } else {
      await addOption(title);
      loadSelectedOptions();
    }
    notifyListeners();
  }
}