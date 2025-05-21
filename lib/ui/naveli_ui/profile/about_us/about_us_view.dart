import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import 'about_us_view_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late AboutUsViewModel mViewModel;
  final cardsData = [
    {
      'title': 'Our Mission & Vision',
      'image': LocalImages.ourMissionImg,
      'bgColor': const Color(0xFFF1E4FF),
    },
    {
      'title': 'Our Team',
      'image': LocalImages.ourTeamImg,
      'bgColor': const Color(0xFFFFF0E7),
    },
    {
      'title': 'Privacy Policy',
      'image': LocalImages.privacyImg,
      'bgColor': const Color(0xFFEAF6FF),
    },
    {
      'title': 'Terms of Use',
      'image': LocalImages.termsImg,
      'bgColor': const Color(0xFFFFFBE7),
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // TODO : Removed about api
      // mViewModel.getAboutUsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AboutUsViewModel>(context);
    return SafeArea(
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.aboutUs,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cardsData.length,
            itemBuilder: (context, index) {
              final data = cardsData[index];
              return InfoCard(
                title: data['title'] as String,
                imagePath: data['image'] as String,
                bgColor: data['bgColor'] as Color,
              );
            },
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color bgColor;

  const InfoCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: CommonColors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                    ),
                    child: Text(
                      S.of(context)!.readMore,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 120,
            width: 120,
            child: Image.asset(
              imagePath,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
