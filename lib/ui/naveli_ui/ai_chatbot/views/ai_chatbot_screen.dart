import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/viewModel/ai_chatbot_viewmodel.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_image_loader.dart';
import '../widgets/typing_indicator.dart';

class AiChatBotScreen extends StatefulWidget {
  @override
  State<AiChatBotScreen> createState() => _AiChatBotScreenState();
}

class _AiChatBotScreenState extends State<AiChatBotScreen> {
  late AiChatBotViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchChatBotData();
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AiChatBotViewModel>(context);

    return Scaffold(
      backgroundColor: CommonColors.mWhite,
      appBar: AppBar(
        backgroundColor: CommonColors.bgGrey,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Transform.translate(
            offset: const Offset(-30, 0),
            child: Text('Neowme',
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
      ),
      body: viewModel.isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TypingIndicator(),
                ),
              ],
            )
          : viewModel.errorMessage.isNotEmpty
              ? Center(child: Text(viewModel.errorMessage))
              : viewModel.chatBotData == null
                  ? const Center(child: Text('No data available'))
                  : ListView.builder(
                      itemCount: viewModel.visibleIndexes.length +
                          (viewModel.showTypingIndicator ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (viewModel.showTypingIndicator &&
                            index == viewModel.visibleIndexes.length) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: TypingIndicator(),
                          );
                        }

                        final question = viewModel.chatBotData!
                            .questions![viewModel.visibleIndexes[index]];
                        return ListTile(
                          title: customMessage(
                              text: question.text ?? '',
                              imageUrl: question.imagePath ?? ''),
                        );
                      },
                    ),
    );
  }
}

Widget customMessage({required String text, String? imageUrl}) {
  if (text == "Display image" && imageUrl != null) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: CustomImageLoader(imageUrl: imageUrl),
      ),
    );
  }
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: CommonColors.bgGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: CommonColors.blackColor,
        ),
      ),
    ),
  );
}
