import 'package:flutter/material.dart';
import '../../../../database/app_preferences.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../model/ai_chatbot_model.dart';

class AiChatBotViewModel with ChangeNotifier {
  AiChatBotModel? _chatBotData;
  bool _isLoading = false;
  String _errorMessage = '';
  final _services = Services();
  List<int> _visibleIndexes = [];
  bool _showTypingIndicator = false;

  AiChatBotModel? get chatBotData => _chatBotData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<int> get visibleIndexes => _visibleIndexes;
  bool get showTypingIndicator => _showTypingIndicator;

  bool get isLastQuestionVisible {
    return visibleIndexes.isNotEmpty &&
        visibleIndexes.last == (chatBotData?.questions?.length ?? 0) - 1;
  }

  List<Option> get lastQuestionOptions {
    if (chatBotData == null || chatBotData!.questions!.isEmpty) {
      return [];
    }
    final lastQuestion = chatBotData!.questions!.last;
    return lastQuestion.options ?? [];
  }

  void handleOptionSelection(Option option) {
    // Handle the selected option
    debugPrint('Selected option: ${option.text}');
    // Add your logic here (e.g., send the answer to the server)
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void addVisibleIndex(int index) {
    _visibleIndexes.add(index);
    notifyListeners();
  }

  void clearVisibleIndexes() {
    _visibleIndexes.clear();
    notifyListeners();
  }

  void setShowTypingIndicator(bool value) {
    _showTypingIndicator = value;
    notifyListeners();
  }

  Future<void> fetchChatBotData() async {
    setLoading(true);
    try {
      Map<String, dynamic> params = {
        'answers': [],
        ApiParams.language: AppPreferences.instance.getLanguageCode(),
      };
      AiChatBotModel? chatBotData =
          await _services.api!.startChatbotApi(params: params);

      if (chatBotData != null) {
        _chatBotData = chatBotData;
        clearVisibleIndexes();
        showMessagesWithDelay();
      } else {
        setErrorMessage('Failed to fetch chatbot data: No data received');
      }
    } catch (e) {
      setErrorMessage('Failed to fetch chatbot data: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> showMessagesWithDelay() async {
    if (_chatBotData?.questions != null) {
      for (int i = 0; i < _chatBotData!.questions!.length; i++) {
        setShowTypingIndicator(true);
        await Future.delayed(
            const Duration(seconds: 2)); // Show typing indicator for 2 seconds
        setShowTypingIndicator(false);
        addVisibleIndex(i);
        await Future.delayed(
            const Duration(milliseconds: 500)); // Delay between messages
      }
    }
  }
}
