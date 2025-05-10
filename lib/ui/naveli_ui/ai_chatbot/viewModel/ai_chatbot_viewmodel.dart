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

  AiChatBotModel? get chatBotData => _chatBotData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
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
      } else {
        setErrorMessage('Failed to fetch chatbot data: No data received');
      }
    } catch (e) {
      setErrorMessage('Failed to fetch chatbot data: $e');
    } finally {
      setLoading(false);
    }
  }

  void clearChatBotData() {
    _chatBotData = null;
    notifyListeners();
  }
}
