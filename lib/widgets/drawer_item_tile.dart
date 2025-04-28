import 'package:flutter/material.dart';
import '../utils/constant.dart';

class DrawerItemTile extends StatelessWidget {
  final String? titleText;
  final String? leadingIcon;
  final Function? onTap;

  const DrawerItemTile({
    @required this.leadingIcon,
    @required this.titleText,
    @required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            Image.asset(
              leadingIcon!,
              height: 18,
              width: 18,
            ),
            const SizedBox(width: 15),
            Text(
              titleText!,
              style: getAppStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
