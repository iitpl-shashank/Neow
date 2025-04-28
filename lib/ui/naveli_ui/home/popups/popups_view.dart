import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/utils/constant.dart';

class PopupsView extends StatefulWidget {
  const PopupsView({super.key});

  @override
  State<PopupsView> createState() => _PopupsViewState();
}

class _PopupsViewState extends State<PopupsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Popups',
        style: getAppStyle(fontSize: 30),
      ),
    );
  }
}
