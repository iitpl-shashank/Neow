import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat_message_type.dart';
import '../../../utils/global_variables.dart';

class Chat {
  final String message;
  final ChatMessageType type;
  final DateTime time;

  Chat({required this.message, required this.type, required this.time});

  factory Chat.sent({required message}) =>
      Chat(message: message, type: ChatMessageType.sent, time: DateTime.now());

  factory Chat.receive({required message}) => Chat(
      message: message, type: ChatMessageType.received, time: DateTime.now());

  static List<Chat> generate() {
    String name = globalUserMaster?.name ?? '';
    String intro = "Hi, $name";

    return [
      Chat(
        message: intro,
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      Chat(
        message: "I'm Neowme, your health buddy. Let's get healthier together!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message:
            "Track your periods, monitor your wellness, and get personalized health tips.",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message: "Let's start your health journey!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message:
            "Listen to your body today, you are on Day $globalPday of your cycle",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message: "How are you feeling today?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),

      /* Chat(
        message: "Yes, it's a great day to go out.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      Chat(
        message: "Have a nice day!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 11)),
      ), */
    ];
  }

// static List<Chat> generate() {
  //   return [
  //     Chat(
  //       message: "Hello!",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 5)),
  //     ),
  //     Chat(
  //       message: "Nice to meet you!",
  //       type: ChatMessageType.received,
  //       time: DateTime.now().subtract(const Duration(minutes: 4)),
  //     ),
  //     Chat(
  //       message: "The weather is nice today.",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 3)),
  //     ),
  //     Chat(
  //       message: "Yes, it's a great day to go out.",
  //       type: ChatMessageType.received,
  //       time: DateTime.now().subtract(const Duration(minutes: 2)),
  //     ),
  //     Chat(
  //       message: "Have a nice day!",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 1)),
  //     ),
  //   ];
  // }
}
