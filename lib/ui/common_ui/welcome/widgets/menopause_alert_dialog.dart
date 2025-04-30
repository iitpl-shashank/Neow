import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:naveli_2023/utils/common_colors.dart'; // Add this import for toast functionality

Future<List<String>?> showMenopauseDialog(BuildContext context) {
  return showDialog<List<String>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _MenopauseDialog(),
  );
}

class _MenopauseDialog extends StatefulWidget {
  @override
  State<_MenopauseDialog> createState() => _MenopauseDialogState();
}

class _MenopauseDialogState extends State<_MenopauseDialog> {
  final List<String> symptoms = [
    'Hot Flushes',
    'Tiredness',
    'Mood Swings',
    'Vaginal Dryness',
    'Decreased Sex Drive',
    'Joint Pain'
  ];

  final Set<String> selectedSymptoms = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'You have reached\nMenopause!',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            'Do you experience:',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '(Select Multiple)',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: symptoms.map((symptom) {
              final isSelected = selectedSymptoms.contains(symptom);
              return ChoiceChip(
                label: Text(symptom),
                selected: isSelected,
                selectedColor: Colors.deepPurple.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.deepPurple : Colors.black,
                ),
                shape: StadiumBorder(
                  side: BorderSide(
                    color:
                        isSelected ? Colors.deepPurple : Colors.grey.shade300,
                  ),
                ),
                onSelected: (_) {
                  setState(() {
                    isSelected
                        ? selectedSymptoms.remove(symptom)
                        : selectedSymptoms.add(symptom);
                  });
                },
                // Remove the default checkmark
                avatar: null,
              );
            }).toList(),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonColors.purple,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            onPressed: () {
              if (selectedSymptoms.isEmpty) {
                // Show toast if no symptoms are selected
                Fluttertoast.showToast(
                  msg: "Please select at least one symptom",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              } else {
                // Proceed if symptoms are selected
                Navigator.of(context).pop(selectedSymptoms.toList());
              }
            },
            child: Text(
              'Continue',
              style:
                  TextStyle(color: Colors.white), // Ensure text color is white
            ),
          )
        ],
      ),
    );
  }
}
