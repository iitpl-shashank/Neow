import 'package:flutter/material.dart';

import '../utils/common_colors.dart';

class NumberDropdown extends StatefulWidget {
  const NumberDropdown({super.key});

  @override
  State<NumberDropdown> createState() => _NumberDropdownState();
}

class _NumberDropdownState extends State<NumberDropdown> {
  String? _selectedNumber; // Make it nullable

  final List<String> _numbers = ['1', '2', '3', '4', '5+'];

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
          child: DropdownButton<String>(
            value: _selectedNumber,
            isExpanded: true,
            hint: const Text(
              'How Many?',
              style: TextStyle(
                fontSize: 14,
                color: CommonColors.blackColor,
              ),
            ), // Placeholder text
            underline: const SizedBox(), // Removes the default underline
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            items: _numbers.map((String number) {
              return DropdownMenuItem<String>(
                value: number,
                child: Text(number),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedNumber = newValue;
              });
            },
          ),
        ),
      ),
    );
  }
}
