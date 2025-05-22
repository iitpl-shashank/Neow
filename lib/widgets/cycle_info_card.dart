import 'package:flutter/material.dart';

import '../generated/i18n.dart';

class CycleInfoCard extends StatelessWidget {
  const CycleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.thumb_up, color: Colors.green),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  S.of(context)!.normalAvgCycleRange,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thumb_up, color: Colors.green),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  S.of(context)!.normalAvgPeriodLength,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
