import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  /* Variables */
  List<Chat> chatList = Chat.generate();
  bool isMood = true;

  /* Controllers */
  late final ScrollController scrollController = ScrollController();
  late final TextEditingController textEditingController =
      TextEditingController();
  late final TextEditingController textMoodEditingController =
      TextEditingController();
  late final FocusNode focusNode = FocusNode();

  /* Intents */

  Future<bool> isMoodCheck() async{
    return isMood;
  }
  Future<void> onFieldSubmitted(String msg) async {
    // if (!isTextFieldEnable) return;

    // 1. chat list
    // print(msg);
    textMoodEditingController.text = msg;
    if(msg =="")
    {    
      msg = textEditingController.text;
    }
    chatList = [
      ...chatList,
      Chat.sent(message: msg),
    ];

    
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textEditingController.text = '';
    notifyListeners();
    if(msg == "yes")
    {
        chatList = [
        ...chatList,
        Chat.receive(message: "Video Comming soon"),
      ];

      
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      textEditingController.text = '';
      notifyListeners();
    }
    else{
        chatList = [
          ...chatList,
          Chat.receive(message: "Hey! It's time for the main event:\nthe menstrual blood show! You'll see a mix of blood, uterine lining tissue, and mucus. The flow is heaviest right now and then it takes it easy."),
        ];

        chatList = [
          ...chatList,
          Chat.receive(message: "Tell us how are you feeling today"),
        ];

        
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );

        textEditingController.text = '';
        notifyListeners();
    }
    

    
  }

  void onFieldChanged(String term) {
    notifyListeners();
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}