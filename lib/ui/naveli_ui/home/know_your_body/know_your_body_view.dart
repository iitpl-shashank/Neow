import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';

import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';

class KnowYourBodyView extends StatefulWidget {
  const KnowYourBodyView({super.key});

  @override
  State<KnowYourBodyView> createState() => _KnowYourBodyViewState();
}

class _KnowYourBodyViewState extends State<KnowYourBodyView> {
  // List<ItemModel> items = [];
  // List<ItemModel> items2 = [];
  //
  // int score = 0;
  // bool gameOver = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initGame();
  // }
  //
  // initGame() {
  //   gameOver = false;
  //   score = 0;
  //   items = [
  //     ItemModel(icon: FontAwesomeIcons.coffee, name: "Coffee", value: "Coffee"),
  //     ItemModel(icon: FontAwesomeIcons.dog, name: "dog", value: "dog"),
  //     ItemModel(icon: FontAwesomeIcons.cat, name: "Cat", value: "Cat"),
  //     ItemModel(icon: FontAwesomeIcons.birthdayCake, name: "Cake", value: "Cake"),
  //     ItemModel(icon: FontAwesomeIcons.bus, name: "bus", value: "bus"),
  //   ];
  //   items2 = List<ItemModel>.from(items);
  //   items.shuffle();
  //   items2.shuffle();
  // }
  bool _isBlueDropped = false;
  bool _isRedDropped = false;
  bool _isYellowDropped = false;
  bool _isGreenDropped = false;
  final String _blue = 'blue';
  final String _red = 'red';
  final String _yellow = 'yellow';
  final String _green = 'green';

  void showSnackBarGlobal(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      textScaleFactor: 2,
    )));
  }

  @override
  Widget build(BuildContext context) {
    // if (items.length == 0) gameOver = true;
    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: CommonColors.mTransparent,
            appBar: const CommonAppBar(
              title: 'Know your body',
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 314,
                    width: 315,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return SizedBox(
                                height: 160,
                                width: 200,
                                child: Image.asset(_isBlueDropped
                                    ? LocalImages.bo
                                    : LocalImages.bt),
                              );
                            },
                            onWillAcceptWithDetails: (data) {
                              return data == _blue;
                            },
                            onAcceptWithDetails: (data) {
                              setState(() {
                                _isBlueDropped = true;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return SizedBox(
                                height: 200,
                                width: 160,
                                child: Image.asset(_isRedDropped
                                    ? LocalImages.ro
                                    : LocalImages.rt),
                              );
                            },
                            onWillAcceptWithDetails: (data) {
                              return data == _red;
                            },
                            onAcceptWithDetails: (data) {
                              setState(() {
                                _isRedDropped = true;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return SizedBox(
                                height: 200,
                                width: 160,
                                child: Image.asset(_isYellowDropped
                                    ? LocalImages.yo
                                    : LocalImages.yt),
                              );
                            },
                            onWillAcceptWithDetails: (data) {
                              return data == _yellow;
                            },
                            onAcceptWithDetails: (data) {
                              setState(() {
                                _isYellowDropped = true;
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: DragTarget<String>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return SizedBox(
                                height: 160,
                                width: 200,
                                child: Image.asset(_isGreenDropped
                                    ? LocalImages.go
                                    : LocalImages.gt),
                              );
                            },
                            onWillAcceptWithDetails: (data) {
                              return data == _green;
                            },
                            onAcceptWithDetails: (data) {
                              setState(() {
                                _isGreenDropped = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.15,
                // ),
                const Divider(
                  thickness: 3,
                  color: Colors.black87,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Visibility(
                        visible: !_isRedDropped,
                        child: Draggable<String>(
                          // Data is the value this Draggable stores.
                          data: _red,
                          feedback: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.ro),
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.ro),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isGreenDropped,
                        child: Draggable<String>(
                          // Data is the value this Draggable stores.
                          data: _green,
                          feedback: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.go),
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.go),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isBlueDropped,
                        child: Draggable<String>(
                          // Data is the value this Draggable stores.
                          data: _blue,
                          feedback: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.bo),
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.bo),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isYellowDropped,
                        child: Draggable<String>(
                          // Data is the value this Draggable stores.
                          data: _yellow,
                          feedback: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.yo),
                            ),
                          ),
                          childWhenDragging: Container(),
                          child: SizedBox(
                            height: 165.0,
                            width: 165.0,
                            child: Center(
                              child: Image.asset(LocalImages.yo),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),

      ///

      // Scaffold(
      //   backgroundColor: CommonColors.mTransparent,
      //   appBar: CommonAppBar(
      //     title: 'Know your body',
      //   ),
      //   body: SingleChildScrollView(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       children: <Widget>[
      //         Text.rich(
      //           TextSpan(
      //             children: [
      //               TextSpan(text: "Score: "),
      //               TextSpan(
      //                 text: "$score",
      //                 style: TextStyle(
      //                   color: CommonColors.primaryColor,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 30.0,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         if (!gameOver)
      //           Row(
      //             children: <Widget>[
      //               Column(
      //                   children: items.map((item) {
      //                 return Container(
      //                   margin: const EdgeInsets.all(8.0),
      //                   child: Draggable<ItemModel>(
      //                     data: item,
      //                     childWhenDragging: Icon(
      //                       item.icon,
      //                       color: Colors.grey,
      //                       size: 50.0,
      //                     ),
      //                     feedback: Icon(
      //                       item.icon,
      //                       color: CommonColors.primaryColor,
      //                       size: 50,
      //                     ),
      //                     child: Icon(
      //                       item.icon,
      //                       color: CommonColors.primaryColor,
      //                       size: 50,
      //                     ),
      //                   ),
      //                 );
      //               }).toList()),
      //               Spacer(),
      //               Column(
      //                   children: items2.map((item) {
      //                 return DragTarget<ItemModel>(
      //                   onAccept: (receivedItem) {
      //                     if (item.value == receivedItem.value) {
      //                       setState(() {
      //                         items.remove(receivedItem);
      //                         items2.remove(item);
      //                         score += 10;
      //                         item.accepting = false;
      //                       });
      //                     } else {
      //                       setState(() {
      //                         score -= 5;
      //                         item.accepting = false;
      //                       });
      //                     }
      //                   },
      //                   onLeave: (receivedItem) {
      //                     setState(() {
      //                       item.accepting = false;
      //                     });
      //                   },
      //                   onWillAccept: (receivedItem) {
      //                     setState(() {
      //                       item.accepting = true;
      //                     });
      //                     return true;
      //                   },
      //                   builder: (context, acceptedItems, rejectedItem) =>
      //                       Container(
      //                     color: item.accepting ? CommonColors.mRed : CommonColors.primaryColor,
      //                     height: 50,
      //                     width: 100,
      //                     alignment: Alignment.center,
      //                     margin: const EdgeInsets.all(8.0),
      //                     child: Text(
      //                       item.name,
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 18.0),
      //                     ),
      //                   ),
      //                 );
      //               }).toList()),
      //             ],
      //           ),
      //         if (gameOver)
      //           Text(
      //             "GameOver",
      //             style: TextStyle(
      //               color: CommonColors.darkPink,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 24.0,
      //             ),
      //           ),
      //         if (gameOver)
      //           Center(
      //             child: MaterialButton(
      //               textColor: Colors.white,
      //               color: CommonColors.primaryColor,
      //               child: Text("New Game"),
      //               onPressed: () {
      //                 initGame();
      //                 setState(() {});
      //               },
      //             ),
      //           )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// class ItemModel {
//   final String name;
//   final String value;
//   final IconData icon;
//   bool accepting;
//
//   ItemModel(
//       {required this.name,
//       required this.value,
//       required this.icon,
//       this.accepting = false});
// }
