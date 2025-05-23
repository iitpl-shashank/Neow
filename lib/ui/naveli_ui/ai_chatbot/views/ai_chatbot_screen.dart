import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/viewModel/ai_chatbot_viewmodel.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/widgets/custom_option_button.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../widgets/custom_image_loader.dart';
import '../widgets/custom_option_multi_button.dart';
import '../widgets/typing_indicator.dart';

class AiChatBotScreen extends StatefulWidget {
  @override
  State<AiChatBotScreen> createState() => _AiChatBotScreenState();
}

class _AiChatBotScreenState extends State<AiChatBotScreen> {
  late AiChatBotViewModel viewModel;
  final ScrollController _scrollController = ScrollController();

  late VoidCallback _scrollListener;

  @override
  void initState() {
    super.initState();
    _scrollListener = () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          final maxScroll = _scrollController.position.maxScrollExtent;
          if (_scrollController.hasClients &&
              viewModel.visibleIndexes.isNotEmpty &&
              maxScroll > 0) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        } catch (e) {
          debugPrint('Scroll error: $e');
        }
      });
    };
  }

  bool _isFirstBuild = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<AiChatBotViewModel>(context);
    viewModel.removeListener(_scrollListener); // Prevent duplicates
    viewModel.addListener(_scrollListener);
    if (_isFirstBuild) {
      _isFirstBuild = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.fetchChatBotData(isStarting: true);
      });
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AiChatBotViewModel>(context);
    return SafeArea(
      child: Scaffold(
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
                : viewModel.chatMessages.isEmpty
                    ? Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          S.of(context)!.noChatBotDataAvailable,
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: viewModel.chatMessages.length +
                                    (viewModel.showTypingIndicator ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (viewModel.showTypingIndicator &&
                                      index ==
                                          viewModel.visibleIndexes.length) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: TypingIndicator(),
                                    );
                                  }
                                  if (index < viewModel.visibleIndexes.length &&
                                      viewModel.visibleIndexes[index] <
                                          viewModel.chatMessages.length) {
                                    final question = viewModel.chatMessages[
                                        viewModel.visibleIndexes[index]];
                                    return customMessage(
                                      context: context,
                                      question: question.text ?? '',
                                      imageUrl: question.imagePath ?? '',
                                      answer: question.userAnswer,
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          if (viewModel.isLastQuestionVisible)
                            Container(
                              color: CommonColors.mTransparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: viewModel.lastQuestionOptions.length == 1
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: CustomOptionButton(
                                        text: viewModel.lastQuestionOptions
                                                .first.text ??
                                            '',
                                        onTap: () => viewModel
                                            .handleOptionSelection(viewModel
                                                .lastQuestionOptions.first),
                                      ),
                                    )
                                  : Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children:
                                          viewModel.lastQuestionOptions.map(
                                        (option) {
                                          print(
                                              '------${option.text}: ${option.isSelected}------');
                                          return CustomOptionMultiButton(
                                            isSelected: option.isSelected,
                                            text: option.text ?? '',
                                            onTap: () => viewModel
                                                .handleOptionSelection(option),
                                          );
                                        },
                                      ).toList(),
                                    ),
                            ),
                        ],
                      ),
      ),
    );
  }
}

Widget customMessage(
    {required String question,
    String? imageUrl,
    String? answer,
    required BuildContext context}) {
  if (question == "Display image" && imageUrl != null) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.66,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: CustomImageLoader(imageUrl: imageUrl),
          ),
        ),
        if (answer != null) const SizedBox(height: 8),
        if (answer != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 15,
                    color: CommonColors.mWhite,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  if (answer != null) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: CommonColors.bgGrey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 15,
                  color: CommonColors.blackColor,
                ),
              ),
            ),
          ),
          if (imageUrl != null && imageUrl.isNotEmpty) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.66,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: CustomImageLoader(imageUrl: imageUrl),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: CommonColors.primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 15,
                  color: CommonColors.mWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: CommonColors.bgGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 15,
                color: CommonColors.blackColor,
              ),
            ),
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              const SizedBox(height: 8),
              CustomImageLoader(imageUrl: imageUrl),
            ],
          ],
        ),
      ),
    ),
  );
}
