import 'dart:async';

import 'package:flutter/material.dart';

class ForgotPsswrdViewModel with ChangeNotifier {
  late BuildContext context;

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
  }
}
