import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/all_about_periods/saved_post_screen.dart';
import '../../../../../utils/common_utils.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 13),
                  Icon(Icons.search, color: Colors.grey.shade500),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              push(
                SavedPostScreen(),
              );
            },
            child: Icon(
              Icons.bookmark_border,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
