import 'package:flutter/material.dart';
import '../model/ai_chatbot_model.dart';

class AiChatBotViewModel with ChangeNotifier {
  // Properties
  AiChatBotModel? _chatBotData;
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  AiChatBotModel? get chatBotData => _chatBotData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Setters
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Fetch chatbot data from API
  Future<void> fetchChatBotData() async {
    setLoading(true);
    try {
      // Simulate API call (replace with actual API call)
      await Future.delayed(const Duration(seconds: 2));

      // Example JSON response (replace with actual API response)
      final jsonResponse = {
        "questions": [
          {
            "id": 1,
            "text": "Hi, NeoW Radha",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path": null
          },
          {
            "id": 2,
            "text":
                "I'm NeoW, your health buddy. Let's get healthier together!",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path": null
          },
          {
            "id": 3,
            "text":
                "Track your periods, monitor your wellness, and get personalised health tips.",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path": null
          },
          {
            "id": 4,
            "text": "Let's start your health journey!",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path": null
          },
          {
            "id": 5,
            "text": "Listen to your body today, you are on Day 1 of your cycle",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path": null
          },
          {
            "id": 6,
            "text": "Display image",
            "is_informational": 1,
            "options": [],
            "user_answer": null,
            "image_path":
                "https://neowindia.com/public/images/uploads/logday/day1.png"
          },
          {
            "id": 11,
            "text": "Do you want to know what’s going on in your body today?",
            "is_informational": 0,
            "options": [
              {"id": 1, "text": "Let's Go"}
            ],
            "user_answer": null,
            "image_path": null
          }
        ],
        "log_day": 1,
        "ovulation_day": "2025-04-26",
        "preovulation_day": "2025-04-25",
        "bot_phase": "Bot 1: Initial Period Phase",
        "message":
            "Hi, Radha! You're on Day 1 of your cycle. Phase: Bot 1: Initial Period Phase",
        "fertile_window_start": "2025-04-21",
        "fertile_window_end": "2025-04-28",
        "period_start_date": "2025-05-10",
        "period_end_date": "2025-05-14"
      };

      // Parse JSON response into AiChatBotModel
      _chatBotData = AiChatBotModel.fromJson(jsonResponse);
    } catch (e) {
      setErrorMessage('Failed to fetch chatbot data: $e');
    } finally {
      setLoading(false);
    }
  }

  // Clear chatbot data
  void clearChatBotData() {
    _chatBotData = null;
    notifyListeners();
  }
}
