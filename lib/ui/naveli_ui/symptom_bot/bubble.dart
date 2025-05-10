library;

import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat.dart';
import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat_message_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';

class Bubble extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Chat chat;

  const Bubble({
    super.key,
    this.margin,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignmentOnType,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin ?? EdgeInsets.zero,
          child: PhysicalShape(
            clipper: clipperOnType,
            elevation: 2,
            color: bgColorOnType,
            shadowColor: Colors.grey.shade200,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: paddingOnType,
              child: Column(
                crossAxisAlignment: crossAlignmentOnType,
                children: [
                  Text(
                    chat.message,
                    style: TextStyle(color: textColorOnType),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color get textColorOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return Colors.white;
      case ChatMessageType.received:
        return const Color(0xFF0F0F0F);
    }
  }

  Color get bgColorOnType {
    switch (chat.type) {
      case ChatMessageType.received:
        return const Color(0xFFF6F6F6);
      case ChatMessageType.sent:
        return const Color(0xFF6F4085);
    }
  }

  CustomClipper<Path> get clipperOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return ChatBubbleClipper5(type: BubbleType.sendBubble);
      case ChatMessageType.received:
        return ChatBubbleClipper5(type: BubbleType.receiverBubble);
    }
  }

  CrossAxisAlignment get crossAlignmentOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return CrossAxisAlignment.end;
      case ChatMessageType.received:
        return CrossAxisAlignment.start;
    }
  }

  MainAxisAlignment get alignmentOnType {
    switch (chat.type) {
      case ChatMessageType.received:
        return MainAxisAlignment.start;

      case ChatMessageType.sent:
        return MainAxisAlignment.end;
    }
  }

  EdgeInsets get paddingOnType {
    switch (chat.type) {
      case ChatMessageType.sent:
        return const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 24);
      case ChatMessageType.received:
        return const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 24,
          right: 10,
        );
    }
  }
}
