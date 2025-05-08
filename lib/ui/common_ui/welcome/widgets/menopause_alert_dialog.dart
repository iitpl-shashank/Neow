import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../../../../generated/i18n.dart'; // Add this import for toast functionality

Future<List<int>?> showMenopauseDialog(BuildContext context) {
  return showDialog<List<int>>(
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
  // final Set<String> selectedSymptoms = {};
  final Set<int> selectedSymptoms = {};

  @override
  Widget build(BuildContext context) {
    // final Map<String, String> symptomsMap = {
    //   S.of(context)!.hotFlushes: "Hot Flushes",
    //   S.of(context)!.tiredness: "Tiredness",
    //   S.of(context)!.moodSwings: "Mood Swings",
    //   S.of(context)!.vaginalDryness: "Vaginal Dryness",
    //   S.of(context)!.decreasedSexDrive: "Decreased Sex Drive",
    //   S.of(context)!.jointPain: "Joint Pain",
    // };

    final Map<String, int> symptomsMap = {
      S.of(context)!.hotFlushes: 1,
      S.of(context)!.tiredness: 2,
      S.of(context)!.moodSwings: 3,
      S.of(context)!.vaginalDryness: 4,
      S.of(context)!.decreasedSexDrive: 5,
      S.of(context)!.jointPain: 6,
    };

    final List<String> symptoms = symptomsMap.keys.toList();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context)!.reachedMenopause,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            S.of(context)!.doYouExp,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            S.of(context)!.selectMultiple,
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: symptoms.map((localizedSymptom) {
              final englishSymptom = symptomsMap[localizedSymptom]!;
              final isSelected = selectedSymptoms.contains(englishSymptom);

              return ChoiceChip(
                label: Text(localizedSymptom),
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
                    if (isSelected) {
                      selectedSymptoms.remove(englishSymptom);
                    } else {
                      selectedSymptoms.add(englishSymptom);
                    }
                  });
                },
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
                  msg: S.of(context)!.pleaseSelectAtleastOne,
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
              S.of(context)!.continueText,
              style:
                  TextStyle(color: Colors.white), // Ensure text color is white
            ),
          )
        ],
      ),
    );
  }
}
