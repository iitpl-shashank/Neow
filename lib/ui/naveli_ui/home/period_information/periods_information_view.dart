import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/period_information/periods_information_content_view.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';

class PeriodsInformationView extends StatefulWidget {
  const PeriodsInformationView({super.key});

  @override
  State<PeriodsInformationView> createState() => _PeriodsInformationViewState();
}

class _PeriodsInformationViewState extends State<PeriodsInformationView> {
  final List<Map<String, dynamic>> dataList = [
    {
      'image': LocalImages.img_periods_information_lady_1,
      'view': '10.1',
    },
    {
      'image': LocalImages.img_periods_information_lady_2,
      'view': '5.6',
    },
    {
      'image': LocalImages.img_periods_information_lady_1,
      'view': '1.1',
    },
    {
      'image': LocalImages.img_periods_information_lady_2,
      'view': '7.63',
    },
    {
      'image': LocalImages.img_periods_information_lady_1,
      'view': '10.8',
    },
    {
      'image': LocalImages.img_periods_information_lady_2,
      'view': '2.4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.periodsInformation,
      ),
      body: Column(
        children: [
          kCommonSpaceV30,
          Expanded(
            child: GridView.builder(
              itemCount: dataList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      push(const PeriodsInformationContentView());
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            dataList[index]['image'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        // shadows: [
                        //   BoxShadow(
                        //     color: Color(0x2D000000),
                        //     blurRadius: 1,
                        //     offset: Offset(0, 4),
                        //     spreadRadius: 0,
                        //   )
                        // ],
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // height: 35,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(0.00, -1.8),
                              end: const Alignment(0, 0.5),
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.black.withOpacity(0.5)
                              ],
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                kCommonSpaceH5,
                                const Icon(
                                  Icons.remove_red_eye_rounded,
                                  color: CommonColors.mWhite,
                                ),
                                kCommonSpaceH5,
                                Text(
                                  '${dataList[index]['view']} k',
                                  style: getAppStyle(
                                    color: CommonColors.mWhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                );
              },
            ),
          ),
          kCommonSpaceV30,
        ],
      ),
    );
  }
}
