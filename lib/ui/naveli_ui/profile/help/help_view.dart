import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../about_us/about_us_view_model.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  late AboutUsViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAboutUsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AboutUsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.help,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: HtmlWidget(
            mViewModel.aboutData?.description ?? '',
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
