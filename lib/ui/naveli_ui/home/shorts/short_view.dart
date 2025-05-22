import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';
import '../../health_mix/health_mix_view_model.dart';

class ShortsView extends StatefulWidget {
  const ShortsView({
    super.key,
  });

  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  late HealthMixViewModel mViewHealthMixModel;
  late HealthMixViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mViewModel.attachedContext(context);
      mViewHealthMixModel =
          Provider.of<HealthMixViewModel>(context, listen: false);
      mViewHealthMixModel.getHealthMixPostsApi(titleId: 1, type: "latest");
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HealthMixViewModel>(context);
    final List<Map<String, dynamic>> tabOptions = [
      {"titleKey": S.of(context)!.latest, "titleId": 1, "type": "latest"},
      {"titleKey": S.of(context)!.popular, "titleId": 2, "type": "popular"},
      {"titleKey": S.of(context)!.oldest, "titleId": 3, "type": "oldest"},
    ];
    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.shorts,
      ),
      body: Column(
        children: [
          // Tab buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                tabOptions.length,
                (index) {
                  String title = "";
                  switch (tabOptions[index]["titleKey"]) {
                    case "latest":
                      title = S.of(context)!.latest;
                      break;
                    case "popular":
                      title = S.of(context)!.popular;
                      break;
                    case "oldest":
                      title = S.of(context)!.oldest;
                      break;
                  }
                  return _buildTabButton(
                    title,
                    isSelected == index,
                    () {
                      setState(() {
                        selectedTabIndex = index;
                      });
                      mViewHealthMixModel.getHealthMixPostsApi(
                        titleId: tabOptions[index]["titleId"],
                        type: tabOptions[index]["type"],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Grid of shorts
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: mViewModel.healthPostsList.length,
              itemBuilder: (context, index) {
                return _buildShortCard(
                  context,
                  mViewModel.healthPostsList[index].hashtags ?? '',
                  mViewModel.healthPostsList[index].description ?? '',
                  mViewModel.healthPostsList[index].diffrenceTime ?? '',
                  mViewModel.healthPostsList[index].mediaType == 'image'
                      ? mViewModel.healthPostsList[index].media ??
                          "https://static.vecteezy.com/system/resources/thumbnails/047/580/461/small/youtube-popular-social-media-logo-free-png.png"
                      : 'https://static.vecteezy.com/system/resources/thumbnails/047/580/461/small/youtube-popular-social-media-logo-free-png.png',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    String title,
    bool isSelected,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        onPressed: () {
          // Handle tab selection logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.purple : Colors.grey[300],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildShortCard(
    BuildContext context,
    String title,
    String subtitle,
    String time,
    String imageAsset,
  ) {
    return Container(
      height: 250,
      decoration: ShapeDecoration(
        color: CommonColors.mWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
        image: DecorationImage(
          image: NetworkImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200, // Adjusted height for image
                width: double.infinity,
              ),
              Positioned(
                top: 150, // Position text a bit lower for spacing
                left: 15,
                right: 15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          offset: Offset(0.5, 0),
                          blurRadius: 1.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 15,
                right: 15,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          offset: Offset(0.5, 0),
                          blurRadius: 1.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
