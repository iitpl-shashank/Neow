import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/widgets/full_screen_image.dart';

class CustomImageLoader extends StatelessWidget {
  final String imageUrl;

  const CustomImageLoader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullscreenImage(imageUrl: imageUrl),
            ));
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[100],
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  strokeWidth: 4,
                ),
              ),
              Positioned(
                bottom: 12,
                child: Text(
                  '${(downloadProgress.progress ?? 0) * 100 ~/ 1}%',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          );
        },
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
