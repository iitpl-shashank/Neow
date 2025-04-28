// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class CustomDateTimePicker extends StatelessWidget {
//
//   const CustomDateTimePicker({super.key, this.labelText, this.hintText, this.onValidate, this.onSaved});
//
//   final String? labelText;
//   final String? hintText;
//   final String? Function(String?)? onValidate;
//   final Function(String?)? onSaved;
//
//   @override
//   Widget build(BuildContext context) {
//     return DateTimePicker(
//       dateLabelText: labelText,
//       fieldHintText: hintText,
//       firstDate: DateTime(1995),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//       validator: onValidate,
//       onSaved: onSaved,
//     );
//   }
// }