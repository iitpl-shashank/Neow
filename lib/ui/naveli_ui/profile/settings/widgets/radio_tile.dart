import 'package:flutter/material.dart';

class RadioTile extends StatelessWidget {
  final String title;
  final bool selected;

  const RadioTile({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected
          ? const Icon(Icons.check, color: Colors.black)
          : const SizedBox.shrink(),
      onTap: () {},
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
