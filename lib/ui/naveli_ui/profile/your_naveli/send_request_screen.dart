import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_text_field.dart';
import '../../../../widgets/primary_button.dart';
import '../../../common_ui/welcome/welcome_view_model.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  late WelcomeViewModel mViewModel;
  final mUniqueIdController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WelcomeViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.sendRequest,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Container(
                // height: 130,
                width: kDeviceWidth / 1,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE5FE).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context)!.naveliUniqueId,
                        style: getAppStyle(
                            color: CommonColors.primaryColor, fontSize: 18),
                      ),
                      kCommonSpaceV15,
                      LabelTextField(
                        hintText: "Enter naveli's Unique Id",
                        controller: mUniqueIdController,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  onPress: () {
                    mViewModel.verifyUniqueIdApi(
                        uniqueId: mUniqueIdController.text.trim(),
                        isFromCycle: false);
                  },
                  label: "Send request",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
