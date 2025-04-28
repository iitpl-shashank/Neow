import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import '../../../../generated/i18n.dart';
import '../../../../widgets/common_appbar.dart';

class PeriodsInformationContentView extends StatefulWidget {
  const PeriodsInformationContentView({super.key});

  @override
  State<PeriodsInformationContentView> createState() =>
      _PeriodsInformationContentViewState();
}

class _PeriodsInformationContentViewState
    extends State<PeriodsInformationContentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.periodsInformation,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Facts About Periods',
                style: getAppStyle(
                  color: CommonColors.darkPink,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "1) These days start when an egg from he previous cycle has not been fertilized. Because pregnancy hasn't taken place, levels of estrogen and progesterone hormones drop.",
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                '2) The thickened lining of your uterus, which would support a pregnancy, is no longer needed, so it sheds through your vagina.',
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "1) These days start when an egg from he previous cycle has not been fertilized. Because pregnancy hasn't taken place, levels of estrogen and progesterone hormones drop.",
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                '2) The thickened lining of your uterus, which would support a pregnancy, is no longer needed, so it sheds through your vagina.',
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "1) These days start when an egg from he previous cycle has not been fertilized. Because pregnancy hasn't taken place, levels of estrogen and progesterone hormones drop.",
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                '2) The thickened lining of your uterus, which would support a pregnancy, is no longer needed, so it sheds through your vagina.',
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "1) These days start when an egg from he previous cycle has not been fertilized. Because pregnancy hasn't taken place, levels of estrogen and progesterone hormones drop.",
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                '2) The thickened lining of your uterus, which would support a pregnancy, is no longer needed, so it sheds through your vagina.',
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
