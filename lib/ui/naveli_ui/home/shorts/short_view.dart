import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/shorts/shorts_swipe_screen.dart';
import 'package:naveli_2023/ui/naveli_ui/home/shorts/shorts_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../widgets/common_appbar.dart';

class ShortsView extends StatefulWidget {
  const ShortsView({
    super.key,
  });

  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  late ShortsViewModel shortsViewModel;
  int selectedTabIndex = 0;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> tabOptions = [
    {
      "titleKey": "Latest",
      "titleId": 1,
      "type": "latest",
    },
    {
      "titleKey": "Popular",
      "titleId": 1,
      "type": "popular",
    },
    {
      "titleKey": "Oldest",
      "titleId": 1,
      "type": "oldest",
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shortsViewModel.attachedContext(context);
      shortsViewModel.getShortsPostsApi(
        shortType: "1",
        type: "latest",
        isRefresh: true,
      );
      tabOptions = [
        {
          "titleKey": S.of(context)!.latest,
          "titleId": 1,
          "type": "latest",
        },
        {
          "titleKey": S.of(context)!.popular,
          "titleId": 1,
          "type": "popular",
        },
        {
          "titleKey": S.of(context)!.oldest,
          "titleId": 1,
          "type": "oldest",
        },
      ];
      setState(() {});
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        shortsViewModel.hasMore &&
        !shortsViewModel.isLoading) {
      shortsViewModel.getShortsPostsApi(
        shortType: tabOptions[selectedTabIndex]["titleId"].toString(),
        type: tabOptions[selectedTabIndex]["type"],
        page: shortsViewModel.currentPage,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    shortsViewModel = Provider.of<ShortsViewModel>(context);

    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.shorts,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  tabOptions.length,
                  (index) {
                    String title = "";
                    switch (tabOptions[index]["type"]) {
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
                      selectedTabIndex == index,
                      () {
                        setState(() {
                          selectedTabIndex = index;
                        });
                        shortsViewModel.getShortsPostsApi(
                          shortType: tabOptions[index]["titleId"].toString(),
                          type: tabOptions[index]["type"],
                          isRefresh: true,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Wrap(
                      spacing: 15.0,
                      runSpacing: 0.0,
                      children: List.generate(
                        shortsViewModel.shortsPostsList.length,
                        (index) {
                          final item = shortsViewModel.shortsPostsList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ShortsSwipeScreen(
                                    shortsList: shortsViewModel.shortsPostsList,
                                    initialIndex: index,
                                    fetchMore: () async {
                                      await shortsViewModel.getShortsPostsApi(
                                        shortType: tabOptions[selectedTabIndex]
                                                ["titleId"]
                                            .toString(),
                                        type: tabOptions[selectedTabIndex]
                                            ["type"],
                                        page: shortsViewModel.currentPage,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 220,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            item.image ??
                                                'https://i.cdn.newsbytesapp.com/images/l51320241229130933.jpeg',
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Icons.broken_image,
                                                  size: 50, color: Colors.grey);
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2 -
                                              20,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.description ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                item.diffrenceTime ?? '',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (shortsViewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    String title,
    bool isSelected,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? CommonColors.primaryColor : Colors.grey[300],
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
}
