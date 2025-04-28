// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view.dart';
// import 'package:naveli_2023/ui/naveli_ui/cycle_info/welcom_gif_view.dart';
// import 'package:naveli_2023/utils/common_colors.dart';
// import 'package:naveli_2023/utils/constant.dart';
// import 'package:naveli_2023/widgets/scaffold_bg.dart';
//
// import '../../../utils/common_utils.dart';
// import '../../../utils/local_images.dart';
//
// class MainWapasAungaView extends StatefulWidget {
//   const MainWapasAungaView({super.key});
//
//   @override
//   State<MainWapasAungaView> createState() => _MainWapasAungaViewState();
// }
//
// class _MainWapasAungaViewState extends State<MainWapasAungaView> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       push(const WelComeGifView());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldBG(
//       bgColor: CommonColors.bglightPinkColor,
//       child:  Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Padding(
//           padding: kCommonAllTopBottomPadding,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 kCommonSpaceV50,
//                 Text(
//                   'Main Wapas Aunga!\nMain Wapas Aunga!',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.piedra(
//                     color: CommonColors.primaryColor,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 kCommonSpaceV30,
//                 Image.asset(
//                   LocalImages.img_vapas_aaunga,
//                   fit: BoxFit.cover,
//                   height: MediaQuery.of(context).size.height / 2.5,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
