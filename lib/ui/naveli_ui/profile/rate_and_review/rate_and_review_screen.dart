import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/rate_and_review/viewModel/rate_and_review_viewmodel.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';

class RateAndReviewScreen extends StatefulWidget {
  const RateAndReviewScreen({super.key});

  @override
  State<RateAndReviewScreen> createState() => _RateAndReviewScreenState();
}

class _RateAndReviewScreenState extends State<RateAndReviewScreen> {
  int selectedStars = 5;
  final TextEditingController _controller = TextEditingController();
  final RateAndReviewViewModel _rateController = RateAndReviewViewModel();

  @override
  void dispose() {
    _controller.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF6F3D8A);
    final Color starColor = Colors.green;

    return Scaffold(
      appBar: CommonAppBar(
        title: S.of(context)!.rateUs,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: AnimatedBuilder(
            animation: _rateController,
            builder: (context, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      LocalImages.feedbackStar,
                      height: 105,
                      width: 105,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      _rateController.ratingText(context),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            Icons.star,
                            size: 32,
                            color: index < _rateController.selectedStars
                                ? starColor
                                : Colors.grey[300],
                          ),
                          onPressed: () {
                            _rateController.setStars(index + 1);
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context)!.yourFeedbackIsAnonymous,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: S.of(context)!.writeUsAReview,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final rating = _rateController.selectedStars;
                        final review = _controller.text.trim();
                        if (review.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                S.of(context)!.writeUsAReview,
                              ),
                            ),
                          );
                          return;
                        }
                        print('Rating: $rating, Review: $review');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context)!.thankYouForYourReview,
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      child: Text(
                        S.of(context)!.submit,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
