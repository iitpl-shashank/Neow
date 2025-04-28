// import 'package:flutter/material.dart';
// import 'package:gif_view/gif_view.dart';
//
// import '../../../utils/local_images.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Demo(),
//     );
//   }
// }
//
// class Demo extends StatefulWidget {
//   const Demo({Key? key}) : super(key: key);
//
//   @override
//   State<Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//   late GifController firstController;
//   late GifController secondController;
//   bool isPlayingFirstGif = true;
//
//   @override
//   void initState() {
//     super.initState();
//     firstController = GifController(
//       autoPlay: true,
//       loop: false,
//       onFinish: onFinished,
//     );
//     secondController = GifController(
//       autoPlay: false,
//       loop: false,
//       onFinish: onFinished,
//     );
//   }
//
//   void onFinished() {
//     print("Finished......");
//   }
//
//   void toggleGif() {
//     setState(() {
//       isPlayingFirstGif = !isPlayingFirstGif;
//       if (isPlayingFirstGif) {
//         firstController.play();
//         secondController.pause(); // Pause the second GIF
//       } else {
//         firstController.pause(); // Pause the first GIF
//         secondController.play();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onDoubleTap: toggleGif,
//         child: Stack(
//           children: [
//             AnimatedOpacity(
//               opacity: isPlayingFirstGif ? 1.0 : 0.0,
//               duration: Duration(milliseconds: 1),
//               child: GifView.asset(
//                 LocalImages.gif_knock_door,
//                 controller: firstController,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: isPlayingFirstGif ? 0.0 : 1.0,
//               duration: Duration(milliseconds: 1),
//               child: GifView.asset(
//                 LocalImages.gif_opendoor,
//                 controller: secondController,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
