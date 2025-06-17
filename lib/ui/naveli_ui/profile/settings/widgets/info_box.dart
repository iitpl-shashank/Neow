import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String text;
  final Widget? endWidget;

  const InfoBox({
    super.key,
    required this.text,
    this.endWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          endWidget != null ? endWidget! : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
