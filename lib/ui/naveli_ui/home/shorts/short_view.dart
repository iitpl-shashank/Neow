// import 'package:flutter/material.dart';
// import '../../../../utils/common_colors.dart';

// // class ShortsView extends StatefulWidget {
// //   const ShortsView({super.key});

// //   @override
// //   State<ShortsView> createState() => _ShortsViewState();
// // }

// class ShortsView extends StatefulWidget {
//   final healthPostsList; // Define the type of your list here

//   const ShortsView({super.key, required this.healthPostsList});

//   @override
//   State<ShortsView> createState() => _ShortsViewState();
// }

// class _ShortsViewState extends State<ShortsView> {
//   @override
//   static const value = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shorts'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           // Tab buttons
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 _buildTabButton('Latest', true),
//                 _buildTabButton('Popular', false),
//                 _buildTabButton('Oldest', false),
//               ],
//             ),
//           ),
//           // Grid of shorts
//           Expanded(
//             child: GridView.builder(
//               padding: EdgeInsets.all(8.0),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // 2 items per row
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 0.8, // Adjust to fit the content nicely
//               ),
//               itemCount: widget.healthPostsList
//                   .length, // You can replace this with your dynamic list length
//               itemBuilder: (context, index) {
//                 return _buildShortCard(
//                   context,
//                   widget.healthPostsList[index].hashtags ?? '',
//                   widget.healthPostsList[index].description ?? '',
//                   widget.healthPostsList[index].diffrenceTime ?? '',
//                   widget.healthPostsList[index].mediaType == 'image'
//                       ? widget.healthPostsList[index].media
//                       : 'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg', // Replace with your image path
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabButton(String title, bool isSelected) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 5.0),
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle tab selection logic here
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected ? Colors.purple : Colors.grey[300],
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildShortCard(BuildContext context, String title, String subtitle,
//       String time, String imageAsset) {
//     return Container(
//       height: 250, // Increased height for the card
//       decoration: ShapeDecoration(
//         color: CommonColors.mWhite,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         shadows: const [
//           BoxShadow(
//             color: Color(0x3F000000),
//             blurRadius: 5,
//             offset: Offset(0, 2),
//             spreadRadius: 0,
//           )
//         ],
//         image: DecorationImage(
//           image: NetworkImage(imageAsset), // URL of the image
//           fit: BoxFit.cover, // Adjust this to control how the image fits
//         ),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 240, // Increased height for the image inside the card
//                 width: double.infinity, // Makes sure image takes full width
//               ),
//               /*Positioned(
//                 top: 150,
//                 left: 15,
//                 child: Container(
//                   color: Colors.white.withOpacity(0.7),
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Text(
//                     title,
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),*/
//               Positioned(
//                 top: 160,
//                 left: 15,
//                 right: 0,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Text(
//                     subtitle,
//                     maxLines: 2, // Limit text to two lines
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(0.5, 0), // Position of the shadow
//                             blurRadius: 1.0,          // Blur effect
//                             color: Colors.white,      // Shadow color
//                           ),
//                         ]),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 200,
//                 left: 15,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Text(
//                     time,
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       shadows: [
//                         Shadow(
//                           offset: Offset(0.5, 0), // Position of the shadow
//                           blurRadius: 1.0,          // Blur effect
//                           color: Colors.white,      // Shadow color
//                         ),
//                       ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../utils/common_colors.dart';

class ShortsView extends StatefulWidget {
  final healthPostsList;

  const ShortsView({super.key, required this.healthPostsList});

  @override
  State<ShortsView> createState() => _ShortsViewState();
}

class _ShortsViewState extends State<ShortsView> {
  @override
  static const value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shorts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Tab buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTabButton('Latest', true),
                _buildTabButton('Popular', false),
                _buildTabButton('Oldest', false),
              ],
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
              itemCount: widget.healthPostsList.length,
              itemBuilder: (context, index) {
                return _buildShortCard(
                  context,
                  widget.healthPostsList[index].hashtags ?? '',
                  widget.healthPostsList[index].description ?? '',
                  widget.healthPostsList[index].diffrenceTime ?? '',
                  widget.healthPostsList[index].mediaType == 'image'
                      ? widget.healthPostsList[index].media
                      : 'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
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

  Widget _buildShortCard(BuildContext context, String title, String subtitle,
      String time, String imageAsset) {
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
                top: 200, // Adjusted to prevent overflow
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
