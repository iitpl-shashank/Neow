import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/viewModel/ai_chatbot_viewmodel.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:provider/provider.dart';

class AiChatBotScreen extends StatefulWidget {
  @override
  State<AiChatBotScreen> createState() => _AiChatBotScreenState();
}

class _AiChatBotScreenState extends State<AiChatBotScreen> {
  late AiChatBotViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.fetchChatBotData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AiChatBotViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
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
          ? const Center(child: CircularProgressIndicator())
          : viewModel.errorMessage.isNotEmpty
              ? Center(child: Text(viewModel.errorMessage))
              : viewModel.chatBotData == null
                  ? Center(child: const Text('No data available'))
                  : ListView.builder(
                      itemCount: viewModel.chatBotData?.questions?.length ?? 0,
                      itemBuilder: (context, index) {
                        final question =
                            viewModel.chatBotData!.questions![index];
                        return ListTile(
                          title: Text(question.text ?? ''),
                        );
                      },
                    ),
    );
  }
}
