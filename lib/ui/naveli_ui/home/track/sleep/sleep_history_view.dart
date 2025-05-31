import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';

class SleeptHistoryView extends StatefulWidget {
  const SleeptHistoryView({super.key});

  @override
  State<SleeptHistoryView> createState() => _SleeptHistoryViewState();
}

class _SleeptHistoryViewState extends State<SleeptHistoryView> {
  late SleepViewModel mViewModel; //fetchSleepData;

  List<String> msr = ['Kg', 'lb'];
  String selectedWeight = '';
  String selectedWeight1 = '';
  String selectedMeasure = '';
  bool isAddWight = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // CommonUtils.showProgressDialog();
      mViewModel.fetchSleepData();

      setState(() {
        mViewModel.fetchSleepData() as List;
        CommonUtils.hideProgressDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SleepViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.sleep,
          actions: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  isAddWight = !isAddWight;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 15,
                    color: CommonColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int index = 0;
                  index < mViewModel.sleeptHistory.length;
                  index++)
                _weight_bmi(context, mViewModel.sleeptHistory[index])
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    return true;
  }
}

Widget _weight_bmi(context, item) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            // height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: CommonColors.mWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)), // Border radius for all edges
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                SizedBox(width: 5), // Space between the dot and text
                Expanded(
                    child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Center the content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        item['month'],
                        textAlign: TextAlign.left,
                        style: getAppStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Evenly space between items
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [],
                      ),
                    ),
                    for (int inx = 0; inx < item['data'].length; inx++)
                      _bmiValue(
                          context,
                          item['data'][inx],
                          '${item['data'][inx]['total_sleep_time'] ?? "Empty"}',
                          item['data'][inx]['date'],
                          '18'),
                  ],
                )),
              ],
            ),
          ),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Widget _bmiValue(context, item, String text, String info, String value) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 10, top: 0, bottom: 0),
          child: Container(
              clipBehavior: Clip.antiAlias,
              height: 60,
              // width: MediaQuery.of(context).size.width - 5,
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
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Center the content
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center vertically
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 111, 64, 133),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          info,
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 102, 100, 100),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        spleepTime(text),
                      ],
                    ), // Space between the dot and text
                  ],
                ),
              )),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Image spleepTime(input) {
  // Regular expression to match hours
  RegExp hourRegExp = RegExp(r'(\d+)Hr');

  // Match the hours
  Match? hourMatch = hourRegExp.firstMatch(input);

  if (hourMatch != null) {
    // Extract and print the hours
    String hourStr = hourMatch.group(1)!;

    int hours = int.parse(hourStr);
    if (hours >= 8) {
      return Image.asset(
        LocalImages.vector,
        fit: BoxFit.contain,
        height: 25,
      );
    } else {
      return Image.asset(
        LocalImages.triangle,
        fit: BoxFit.contain,
        height: 25,
      );
    }
  } else {
    return Image.asset(
      LocalImages.triangle,
      fit: BoxFit.contain,
      height: 30,
    );
  }
}
