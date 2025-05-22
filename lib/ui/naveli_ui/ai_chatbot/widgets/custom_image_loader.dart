import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/widgets/full_screen_image.dart';
import 'package:naveli_2023/utils/constant.dart';

class CustomImageLoader extends StatelessWidget {
  final String imageUrl;

  const CustomImageLoader({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.contains(',')) {
      final urls = imageUrl
          .split(',')
          .map((e) => e.trim().startsWith('http')
              ? e.trim()
              : 'https://neowindia.com/${e.trim()}')
          .toList();

      return _MultiImageViewer(urls: urls);
    }

    // Single image fallback
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullscreenImage(imageUrl: imageUrl),
          ),
        );
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

class _MultiImageViewer extends StatefulWidget {
  final List<String> urls;
  const _MultiImageViewer({required this.urls});

  @override
  State<_MultiImageViewer> createState() => _MultiImageViewerState();
}

class _MultiImageViewerState extends State<_MultiImageViewer> {
  int currentIndex = 0;

  void _showPrev() {
    setState(() {
      currentIndex =
          (currentIndex - 1 + widget.urls.length) % widget.urls.length;
    });
  }

  void _showNext() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.urls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.urls[currentIndex];
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      width: kDeviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: _showPrev,
                  tooltip: 'Previous Image',
                ),
                IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  onPressed: _showNext,
                  tooltip: 'Next Image',
                ),
              ],
            ),
          ),
          // Image
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullscreenImage(imageUrl: url),
                ),
              );
            },
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.contain,
              height: 200,
              width: kDeviceWidth,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: kDeviceWidth,
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
          ),
        ],
      ),
    );
  }
}
