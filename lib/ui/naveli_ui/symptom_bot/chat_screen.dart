import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat.dart';
import 'package:naveli_2023/ui/naveli_ui/symptom_bot/chat_controller.dart';
import 'package:naveli_2023/ui/naveli_ui/symptom_bot/bubble.dart';
import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:naveli_2023/utils/local_images.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  bool isMood = false;
  String msg = "Let's Go";

  @override
  Widget build(BuildContext context) {
    // bool is mood = true;

    List<Map<String, dynamic>> dialogData = [
      {
        "id": 1,
        "title": "Relaxed",
        "message": "Aaj Khush to bahut hoge tum",
        "image": LocalImages.emoji_mood_1,
        "isMultiple": false,
      },
      {
        "id": 2,
        "title": "Sad",
        "message": "Pushpa, I hate tears",
        "image": LocalImages.emoji_mood_2,
        "isMultiple": false,
      },
      {
        "id": 3,
        "title": "Irritated",
        "message": "Saala ye dukh kaahe khatam nahi hota hai be",
        "image": LocalImages.emoji_mood_3,
        "isMultiple": false,
      },
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Neowme",
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            pushAndRemoveUntil(const BottomNavbarView());
          },
        ),
        backgroundColor: const Color(0xFFCCCCCC),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<ChatController>().focusNode.unfocus();
                // FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Selector<ChatController, List<Chat>>(
                  selector: (context, controller) =>
                      controller.chatList.reversed.toList(),
                  builder: (context, chatList, child) {
                    return ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 12, bottom: 20) +
                          const EdgeInsets.symmetric(horizontal: 12),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      controller:
                          context.read<ChatController>().scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Bubble(chat: chatList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Visibility(
              visible: true,
              child: Container(
                width: kDeviceWidth / 1.1,
                decoration: ShapeDecoration(
                  color: isMood
                      ? CommonColors.bglightPinkColor
                      : Color(0xFF6F4085),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // kCommonSpaceV20,
                      if (isMood) ...[
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            children: List.generate(
                              dialogData.length,
                              (emojiIndex) {
                                final emojiData = dialogData[emojiIndex];
                                final isSelected = false;
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ChatController>()
                                        .onFieldSubmitted(emojiData['title']);
                                    setState(() => msg = 'continue');
                                    setState(() => isMood = false);
                                    /* context.read<ChatController>().textMoodEditingController.text = emojiData['title'];
                                    print(context.read<ChatController>().textMoodEditingController.text); */
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        emojiData['image'],
                                        fit: BoxFit.contain,
                                        height: 60,
                                        width: 60,
                                      ),
                                      kCommonSpaceV10,
                                      Text(
                                        emojiData['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: isSelected
                                              ? CommonColors.mRed
                                              : CommonColors.blackColor,
                                          fontSize: 15,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w500,
                                          height: 0.5,
                                        ),
                                      ),
                                      kCommonSpaceV20
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                      // kCommonSpaceV20,
                      if (!isMood) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigator.pop(context);
                                context
                                    .read<ChatController>()
                                    .onFieldSubmitted(msg);
                                setState(() => isMood = true);
                              },
                              child: Text(
                                msg,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 18,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const _BottomInputField(),
        ],
      ),
    );
  }
}

/// Bottom Fixed Filed
class _BottomInputField extends StatelessWidget {
  const _BottomInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
        ),
        child: Stack(
          children: [
            TextField(
              focusNode: context.read<ChatController>().focusNode,
              onChanged: context.read<ChatController>().onFieldChanged,
              controller: context.read<ChatController>().textEditingController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  right: 42,
                  left: 16,
                  top: 18,
                ),
                hintText: 'type here...',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            // custom suffix btn
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/send.svg",
                  colorFilter: ColorFilter.mode(
                    context.select<ChatController, bool>(
                            (value) => value.isTextFieldEnable)
                        ? const Color(0xFF007AFF)
                        : const Color(0xFFBDBDC2),
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  context.read<ChatController>().onFieldSubmitted("");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
