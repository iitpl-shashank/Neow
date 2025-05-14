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
  List<Question> _chatMessages = [];
  List<Question> get chatMessages => _chatMessages;

  bool get isLastQuestionVisible {
    return visibleIndexes.isNotEmpty &&
        visibleIndexes.last == (chatMessages.length) - 1;
  }

  List<Option> get lastQuestionOptions {
    if (chatMessages.isEmpty) {
      return [];
    }
    final lastQuestion = chatMessages.last;
    return lastQuestion.options ?? [];
  }

  Future<void> handleOptionSelection(Option option) async {
    setLoading(true);
    debugPrint('Selected option: ${option.text}');

    int answerId = option.id ?? 0;
    int? questionId = chatBotData?.questions?.isNotEmpty == true
        ? chatBotData?.questions?.last.id
        : null;

    Map<String, dynamic> myParams = {
      'answers': [
        {
          ApiParams.chatbot_question_id: questionId,
          ApiParams.chatbot_answer: answerId,
        }
      ],
      ApiParams.language: AppPreferences.instance.getLanguageCode(),
    };
    addAnswerToLastQuestion(option);
    await fetchChatBotData(
      myParams: myParams,
      isStarting: false,
    );
    setLoading(false);
  }

  void addAnswerToLastQuestion(Option answer) {
    if (_chatMessages.isNotEmpty) {
      _chatMessages.last.userAnswer = answer.text;
      notifyListeners();
    }
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

  Future<void> fetchChatBotData({
    Map<String, dynamic>? myParams,
    bool isStarting = false,
  }) async {
    if (isStarting) {
      setLoading(true);
    } else {
      setShowTypingIndicator(true);
    }
    try {
      Map<String, dynamic> params = {
        'answers': [],
        ApiParams.language: AppPreferences.instance.getLanguageCode(),
      };
      AiChatBotModel? chatBotData =
          await _services.api!.startChatbotApi(params: myParams ?? params);
      if (isStarting) {
        _chatMessages.clear();
        clearVisibleIndexes();
      }
      if (chatBotData != null) {
        _chatMessages.addAll(chatBotData.questions ?? []);
        _chatBotData = chatBotData;

        showMessagesWithDelay(isStarting: isStarting);
      } else {
        setErrorMessage('Failed to fetch chatbot data: No data received');
      }
    } catch (e) {
      setErrorMessage('Failed to fetch chatbot data: $e');
    } finally {
      if (isStarting) {
        setLoading(false);
      } else {
        setShowTypingIndicator(false);
      }
    }
  }

  Future<void> showMessagesWithDelay({required bool isStarting}) async {
    if (chatMessages.isEmpty) return;

    if (isStarting) {
      int lastAnsweredIndex = -1;
      for (int i = 0; i < chatMessages.length; i++) {
        if (chatMessages[i].userAnswer != null) {
          lastAnsweredIndex = i;
        }
      }

      print("Last answered index: $lastAnsweredIndex");
      print("Chat Msg Length: ${chatMessages.length}");

      if (lastAnsweredIndex == -1) {
        for (int i = 0; i < chatMessages.length; i++) {
          setShowTypingIndicator(true);
          await Future.delayed(const Duration(seconds: 2));
          setShowTypingIndicator(false);
          addVisibleIndex(i);
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } else {
        for (int i = 0; i <= lastAnsweredIndex; i++) {
          addVisibleIndex(i);
        }

        int nextQuestionIndex = lastAnsweredIndex + 1;
        if (nextQuestionIndex < chatMessages.length) {
          for (int j = nextQuestionIndex; j < chatMessages.length; j++) {
            setShowTypingIndicator(true);
            await Future.delayed(const Duration(seconds: 2));
            setShowTypingIndicator(false);
            addVisibleIndex(j);
          }
        }
      }
    } else {
      int start = _visibleIndexes.isEmpty ? 0 : _visibleIndexes.last + 1;
      for (int i = start; i < chatMessages.length; i++) {
        setShowTypingIndicator(true);
        await Future.delayed(const Duration(seconds: 2));
        setShowTypingIndicator(false);
        addVisibleIndex(i);
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }
}
