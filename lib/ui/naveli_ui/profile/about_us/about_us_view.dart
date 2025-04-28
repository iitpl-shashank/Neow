import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';
import 'about_us_view_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
          title: S.of(context)!.aboutUs,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: HtmlWidget(
            mViewModel.aboutData?.aboutUs ?? '',
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
