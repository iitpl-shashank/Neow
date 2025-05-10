import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../generated/i18n.dart';
import '../ui/naveli_ui/profile/dashboard/dashboard_view_model.dart';
import '../utils/common_colors.dart';

class NumberDropdown extends StatefulWidget {
  const NumberDropdown({super.key});

  @override
  State<NumberDropdown> createState() => _NumberDropdownState();
}

class _NumberDropdownState extends State<NumberDropdown> {
  String? _selectedNumber; // Make it nullable

  final List<int> items = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 150,
        height: 40, // Set the width to 130
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: ShapeDecoration(
            color: CommonColors.mWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)), // Border radius for all edges
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Consumer<DashBoardViewModel>(
            builder: (context, vModel, child) {
              return DropdownButton<int>(
                value: vModel.numberOfKids,
                hint: Text(
                  S.of(context)!.howMany,
                  style: TextStyle(
                    fontSize: 14,
                    color: CommonColors.blackColor,
                  ),
                ),
                isExpanded: true, // Make dropdown expand to full width
                onChanged: (int? newValue) {
                  vModel.updateNumberOfKids(newValue ?? 0); // Update ViewModel
                },
                items: items.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

// class NumberDropdown extends StatelessWidget {
//   final List<int> items = [1, 2, 3, 4, 5]; 

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
