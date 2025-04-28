import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/super_women/super_women_information_view.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';

class SuperWomenView extends StatefulWidget {
  const SuperWomenView({super.key});

  @override
  State<SuperWomenView> createState() => _SuperWomenViewState();
}

class _SuperWomenViewState extends State<SuperWomenView> {
  List<String> images = [
    'https://www.theweek.in/content/dam/week/magazine/theweek/specials/images/2022/3/6/42-delisha-davis.jpg.transform/schema-16x9/image.jpg',
    'https://assets.thehansindia.com/h-upload/2021/03/29/1600x960_1064930-yogita-raghuvanshi.jpg',
    'https://police.un.org/sites/default/files/field/image/dr._kiran_bedi2.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/2/24/Sarla_Thakral.jpg',
    'https://curlytales.com/wp-content/uploads/2019/06/global-institutes-e1560770701155.jpg',
    'https://cdn.asianmma.com/wp-content/uploads/2021/09/Puja-Tomar.jpg',
  ];

  final List<Map<String, dynamic>> dataList = [
    {
      'name': 'Delisha Davis',
      'title': 'India’s First Fuel Tanker Driver',
    },
    {
      'name': 'Yogita Raghuvanshi',
      'title': 'India’s First Truck Driver',
    },
    {
      'name': 'Kiran Bedi',
      'title': 'India’s First IPS Officer',
    },
    {
      'name': 'Sarla  Thukral',
      'title': 'India’s Pilot',
    },
    {
      'name': 'Mohana Singh',
      'title': 'India’s First Fighter Pilot',
    },
    {
      'name': 'Puja Tomar',
      'title': 'India’s First MMA Fighter',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.superWomen,
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
                      push(const SuperWomenInformationView());
                    },
                    child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 35,
                            width: double.infinity,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dataList[index]['title'],
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    dataList[index]['name'],
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFFF32C5A),
                                      fontSize: 10,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
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
