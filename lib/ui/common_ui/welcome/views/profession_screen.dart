import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/welcome/views/personalising_screen.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/widgets/common_text_field.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/primary_button.dart';
import '../../../app/app_model.dart';
import '../../../naveli_ui/cycle_info/cycle_info_view_model.dart';

class ProfessionScreen extends StatefulWidget {
  final Map<String, dynamic> welcomeData;
  ProfessionScreen({super.key, required this.welcomeData});

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  final mProfessionController = TextEditingController();
  late CycleInfoViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mViewModel = Provider.of<CycleInfoViewModel>(context, listen: false);
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<CycleInfoViewModel>(context);
    return SafeArea(child: ScaffoldBG(
      child: Builder(builder: (context) {
        var lang = Provider.of<AppModel>(context).locale;
        return Scaffold(
          backgroundColor: CommonColors.mWhite,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                          color: CommonColors.primaryColor),
                    ),
                  ),
                  kCommonSpaceV30,
                  Text(
                    S.of(context)!.profession,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 24,
                      fontWeight:
                          lang == "hi" ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    LocalImages.professionImg,
                    height: 300,
                    width: 250,
                  ),
                  Container(
                    width: kDeviceWidth / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          kCommonSpaceV15,
                          Text(
                            S.of(context)!.tellUsProfession,
                            style: TextStyle(
                              color: CommonColors.blackColor,
                              fontSize: 16,
                              fontWeight: lang == "hi"
                                  ? FontWeight.w200
                                  : FontWeight.w500,
                            ),
                          ),
                          kCommonSpaceV15,
                          LabelTextField(
                            hintText: S.of(context)!.typeHere,
                            controller: mProfessionController,
                            isOnlyChar: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  kCommonSpaceV30,
                  kCommonSpaceV30,
                  kCommonSpaceV30,
                  PrimaryButton(
                    width: kDeviceWidth / 1.3,
                    borderRadius: BorderRadius.circular(50),
                    label: S.of(context)!.next,
                    onPress: () {
                      if (mProfessionController.text.isEmpty) {
                        CommonUtils.showSnackBar(
                          S.of(context)!.pleaseEnterProfession,
                          color: CommonColors.mRed,
                        );
                      } else {
                        mViewModel.userUpdateDetailsApi(
                          isFromCycle: true,
                          roleId: "4",
                          name: widget.welcomeData['name'],
                          birthdate: widget.welcomeData['birthdate'],
                          gender: widget.welcomeData['gender'],
                          genderType: widget.welcomeData['otherGender'],
                          relationshipStatus: widget.welcomeData['relation'],
                          profession: mProfessionController.text,
                        );
                        push(const PersonalisingScreen());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}
