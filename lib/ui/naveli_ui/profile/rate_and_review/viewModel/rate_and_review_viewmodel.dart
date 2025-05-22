import 'package:flutter/material.dart';

import '../../../../../generated/i18n.dart';

class RateAndReviewViewModel extends ChangeNotifier {
  int selectedStars;
  RateAndReviewViewModel({this.selectedStars = 5});

  void setStars(int stars) {
    selectedStars = stars;
    notifyListeners();
  }

  String ratingText(BuildContext context) {
    switch (selectedStars) {
      case 1:
        return S.of(context)!.veryBad;
      case 2:
        return S.of(context)!.bad;
      case 3:
        return S.of(context)!.good;
      case 4:
        return S.of(context)!.veryGood;
      case 5:
      default:
        return S.of(context)!.excellent;
    }
  }
}
