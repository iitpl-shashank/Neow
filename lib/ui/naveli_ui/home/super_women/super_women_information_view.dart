import 'package:flutter/material.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';

class SuperWomenInformationView extends StatefulWidget {
  const SuperWomenInformationView({super.key});

  @override
  State<SuperWomenInformationView> createState() =>
      _SuperWomenInformationViewState();
}

class _SuperWomenInformationViewState extends State<SuperWomenInformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.superWomen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'India’s First IPS Officer - Kiran Bedi',
                style: getAppStyle(
                  color: CommonColors.darkPink,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "Kiran Bedi,PPMG,PNBB is a former tennis player who became the first woman is India to join the officer ranks of the IPS in 1972 and was the 24th Lieutenant Governor of Puducherry from 28 May2016 to 16 February 2021.She remained in service for 35 years before taking voluntary retirement in2007 as Director General, Bureau of Police Research and Development.",
                style: getAppStyle(
                  color: const Color(0xFF8B8B8B),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "Kiran Bedi,PPMG,PNBB is a former tennis player who became the first woman is India to join the officer ranks of the IPS in 1972 and was the 24th Lieutenant Governor of Puducherry from 28 May2016 to 16 February 2021.She remained in service for 35 years before taking voluntary retirement in2007 as Director General, Bureau of Police Research and Development.",
                style: getAppStyle(
                  color: const Color(0xFF8B8B8B),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "Kiran Bedi,PPMG,PNBB is a former tennis player who became the first woman is India to join the officer ranks of the IPS in 1972 and was the 24th Lieutenant Governor of Puducherry from 28 May2016 to 16 February 2021.She remained in service for 35 years before taking voluntary retirement in2007 as Director General, Bureau of Police Research and Development.",
                style: getAppStyle(
                  color: const Color(0xFF8B8B8B),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              Text(
                "Kiran Bedi,PPMG,PNBB is a former tennis player who became the first woman is India to join the officer ranks of the IPS in 1972 and was the 24th Lieutenant Governor of Puducherry from 28 May2016 to 16 February 2021.She remained in service for 35 years before taking voluntary retirement in2007 as Director General, Bureau of Police Research and Development.",
                style: getAppStyle(
                  color: const Color(0xFF8B8B8B),
                  fontSize: 18,
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
