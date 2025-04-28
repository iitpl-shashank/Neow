import 'package:flutter/material.dart';
import 'package:naveli_2023/generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/global_variables.dart';
import 'package:naveli_2023/utils/local_images.dart';

class SymptomsBotView extends StatefulWidget {
  const SymptomsBotView({super.key});

  @override
  State<SymptomsBotView> createState() => _SymptomsBotViewState();
}

class _SymptomsBotViewState extends State<SymptomsBotView> {
  final List<Message> _messages = [];
  ScrollController _scrollController = new ScrollController();

  bool isAnsSelected = false;

  // Nested array structure for questions and follow-up questions with IDs and images
  final List<List<Map<String, dynamic>>> questionsTree = [
    [
      {
        "id": 1,
        "question": "What's your favorite color?",
        "image": "",
        "answers": [
          {
            "id": 101,
            "text": "Lets Go",
            "image": "",
            "next": [
              {
                "id": 201,
                "question":
                    "Hey! It's time for the main event: the menstrual blood show! 🎭 You'll see a mix of blood, uterine lining tissue, and mucus. The flow is heaviest right now and then it takes it easy.",
                "image": ""
              },
              {"id": 202, "question": "Symptoms to expect today", "image": ""},
              {"id": 203, "question": "", "image": LocalImages.chat2},
              {
                "id": 204,
                "question": "Tell us how are you feeling today?",
                "image": ""
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 2,
        "question": "What is your favorite cuisine?",
        "image": "",
        "answers": [
          {
            "id": 105,
            "text": "Relaxed",
            "image": LocalImages.laugh,
            "next": [
              {
                "id": 213,
                "question": "Can you tell us about your energy levels?",
                "image": ""
              },
            ]
          },
          {
            "id": 106,
            "text": "Irritated",
            "image": LocalImages.irritability,
            "next": [
              {
                "id": 216,
                "question": "Can you tell us about your energy levels?",
                "image": ""
              },
            ]
          },
          {
            "id": 107,
            "text": "Sad",
            "image": LocalImages.sad,
            "next": [
              {
                "id": 219,
                "question": "Can you tell us about your energy levels?",
                "image": ""
              },
            ]
          }
        ]
      }
    ],
    [
      {
        "id": 3,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 401,
            "text": "Lively",
            "image": LocalImages.img_energy_1,
            "next": [
              {
                "id": 290,
                "question": "Can you tell us about your stress levels?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Normal",
            "image": LocalImages.img_energy_2,
            "next": [
              {
                "id": 271,
                "question": "Can you tell us about your stress levels?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Tired",
            "image": LocalImages.img_energy_3,
            "next": [
              {
                "id": 228,
                "question": "Can you tell us about your stress levels?",
                "image": ""
              },
            ]
          }
        ]
      }
    ],
    [
      {
        "id": 4,
        "question": "What type of music do you enjoy?",
        "image": LocalImages.img_stress_1,
        "answers": [
          {
            "id": 402,
            "text": "Low",
            "image": LocalImages.img_stress_1,
            "next": [
              {
                "id": 291,
                "question": "Tell us about your working ability?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Moderate",
            "image": LocalImages.img_stress_2,
            "next": [
              {
                "id": 272,
                "question": "Tell us about your working ability?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "High",
            "image": LocalImages.img_stress_3,
            "next": [
              {
                "id": 228,
                "question": "Tell us about your working ability?",
                "image": ""
              },
            ]
          }
        ]
      }
    ],
    [
      {
        "id": 5,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 403,
            "text": "Very Active",
            "image": LocalImages.img_working_4,
            "next": [
              {
                "id": 292,
                "question": "Are you experiencing any physical pain today?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Active",
            "image": LocalImages.img_working_2,
            "next": [
              {
                "id": 273,
                "question": "Are you experiencing any physical pain today?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Somewhat Active",
            "image": LocalImages.img_working_3,
            "next": [
              {
                "id": 228,
                "question": "Are you experiencing any physical pain today?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Inactive",
            "image": LocalImages.img_working_1,
            "next": [
              {
                "id": 228,
                "question": "Are you experiencing any physical pain today?",
                "image": ""
              },
            ]
          }
        ]
      }
    ],
    [
      {
        "id": 6,
        "question": "What type of music do you enjoy?",
        "image": LocalImages.img_location_1,
        "answers": [
          {
            "id": 404,
            "text": "Headache",
            "image": LocalImages.img_location_1,
            "next": [
              {
                "id": 293,
                "question": "How are your period cramps?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Backache",
            "image": LocalImages.img_location_2,
            "next": [
              {
                "id": 275,
                "question": "How are your period cramps?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Leg Pain",
            "image": LocalImages.img_location_3,
            "next": [
              {
                "id": 228,
                "question": "How are your period cramps?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Abdominal Pain",
            "image": LocalImages.img_location_4,
            "next": [
              {
                "id": 228,
                "question": "How are your period cramps?",
                "image": ""
              },
            ]
          },
          {
            "id": 111,
            "text": "Other",
            "image": "",
            "next": [
              {
                "id": 228,
                "question": "How are your period cramps?",
                "image": ""
              },
            ]
          }
        ]
      }
    ],
    [
      {
        "id": 7,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 404,
            "text": "No Pain",
            "image": LocalImages.img_cramps_1,
            "next": [
              {
                "id": 294,
                "question": "For how many days do you feel pain?",
                "image": ""
              },
            ]
          },
          {
            "id": 111,
            "text": "Little",
            "image": LocalImages.img_cramps_2,
            "next": [
              {
                "id": 316,
                "question": "For how many days do you feel pain?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Bad",
            "image": LocalImages.img_cramps_3,
            "next": [
              {
                "id": 276,
                "question": "For how many days do you feel pain?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Severe",
            "image": LocalImages.img_cramps_4,
            "next": [
              {
                "id": 228,
                "question": "For how many days do you feel pain?",
                "image": ""
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 8,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 405,
            "text": "0",
            "image": "",
            "next": [
              {
                "id": 295,
                "question": "What about your flow and clot size today?",
                "image": ""
              },
            ]
          },
          {
            "id": 111,
            "text": "1-2",
            "image": "",
            "next": [
              {
                "id": 311,
                "question": "What about your flow and clot size today?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "2-3",
            "image": "",
            "next": [
              {
                "id": 277,
                "question": "What about your flow and clot size today?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "4+",
            "image": "",
            "next": [
              {
                "id": 228,
                "question": "What about your flow and clot size today?",
                "image": ""
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 9,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 406,
            "text": "Low",
            "image": "",
            "next": [
              {"id": 296, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 111,
            "text": "Medium",
            "image": "",
            "next": [
              {"id": 312, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 109,
            "text": "High",
            "image": "",
            "next": [
              {"id": 278, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 110,
            "text": "Clot size",
            "image": "",
            "next": [
              {"id": 228, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 112,
            "text": "Small",
            "image": "",
            "next": [
              {"id": 228, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 113,
            "text": "Medium",
            "image": "",
            "next": [
              {"id": 228, "question": "How severe is your acne?", "image": ""},
            ]
          },
          {
            "id": 114,
            "text": "Large",
            "image": "",
            "next": [
              {"id": 228, "question": "How severe is your acne?", "image": ""},
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 10,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 407,
            "text": "None",
            "image": LocalImages.img_acne_1,
            "next": [
              {
                "id": 297,
                "question": "What’s your collection method?",
                "image": ""
              },
            ]
          },
          {
            "id": 111,
            "text": "Minimal",
            "image": LocalImages.img_acne_2,
            "next": [
              {
                "id": 313,
                "question": "What’s your collection method?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Severe",
            "image": LocalImages.img_acne_3,
            "next": [
              {
                "id": 290,
                "question": "What’s your collection method?",
                "image": ""
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 11,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 408,
            "text": "Sanitary Pads",
            "image": LocalImages.img_collection_4,
            "next": [
              {
                "id": 298,
                "question":
                    "How often do you change your period product in a day?",
                "image": ""
              },
            ]
          },
          {
            "id": 111,
            "text": "Cup",
            "image": LocalImages.img_collection_3,
            "next": [
              {
                "id": 314,
                "question":
                    "How often do you change your period product in a day?",
                "image": ""
              },
            ]
          },
          {
            "id": 109,
            "text": "Tampons",
            "image": LocalImages.img_collection_2,
            "next": [
              {
                "id": 280,
                "question":
                    "How often do you change your period product in a day?",
                "image": ""
              },
            ]
          },
          {
            "id": 110,
            "text": "Cloth",
            "image": LocalImages.img_collection_1,
            "next": [
              {
                "id": 281,
                "question":
                    "How often do you change your period product in a day?",
                "image": ""
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 12,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 409,
            "text": "4 Times",
            "image": "",
            "next": [
              {
                "id": 299,
                "question": "Iron heroes to the rescue!",
                "image": LocalImages.fourts
              },
            ]
          },
          {
            "id": 111,
            "text": "3 Times",
            "image": "",
            "next": [
              {
                "id": 315,
                "question": "Iron heroes to the rescue!",
                "image": LocalImages.fourts
              },
            ]
          },
          {
            "id": 109,
            "text": "2 Times",
            "image": "",
            "next": [
              {
                "id": 282,
                "question": "Iron heroes to the rescue!",
                "image": LocalImages.fourts
              },
            ]
          },
          {
            "id": 110,
            "text": "1 Times",
            "image": "",
            "next": [
              {
                "id": 283,
                "question": "Iron heroes to the rescue!",
                "image": ""
              },
              {"id": 284, "question": "", "image": LocalImages.fourts},
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 13,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 151,
            "text": "Thanks for the tip! I'll keep that in mind.",
            "image": "",
            "next": [
              {
                "id": 152,
                "question": "Stay refreshed like a mermaid 🧜🏼‍♀️",
                "image": "",
              },
              {
                "id": 153,
                "question": "",
                "image": LocalImages.chat8,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 14,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 151,
            "text": "Thanks for reminding.",
            "image": "",
            "next": [
              {
                "id": 152,
                "question": "Keeping inflammation and cramps at bay with:",
                "image": "",
              },
              {
                "id": 153,
                "question": "",
                "image": LocalImages.fish,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 14,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 155,
            "text": "That’s great!",
            "image": "",
            "next": [
              {
                "id": 156,
                "question": "Get steady energy for the win with complex carbs.",
                "image": "",
              },
              {
                "id": 157,
                "question": "",
                "image": LocalImages.vegitables,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 14,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 158,
            "text": "Let’s do this!",
            "image": "",
            "next": [
              {
                "id": 159,
                "question":
                    "Relax those muscles like a pro with magnesium-rich food: ",
                "image": "",
              },
              {
                "id": 160,
                "question": "",
                "image": LocalImages.nuts,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 14,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 158,
            "text": "Thanks for the recommendations!",
            "image": "",
            "next": [
              {
                "id": 159,
                "question":
                    "We suggest you sleep like a queen 👑 and take it easy today.",
                "image": "",
              },
              {
                "id": 160,
                "question": "",
                "image": LocalImages.sleepy,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 18,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 158,
            "text": "I'll take it easy today.",
            "image": "",
            "next": [
              {
                "id": 159,
                "question":
                    "Take gentle walks or do yoga - think graceful ballerina 🩰",
                "image": "",
              },
              {
                "id": 160,
                "question": "",
                "image": LocalImages.chatWooman,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 19,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 167,
            "text": "Thanks for the suggestion!",
            "image": "",
            "next": [
              {
                "id": 168,
                "question":
                    "Put a heat pad on the tummy - warm and cozy, like a hug.",
                "image": "",
              },
              {
                "id": 169,
                "question": "",
                "image": LocalImages.feelsSoNice,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 20,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 1001,
            "text": "Sounds relaxing! I'll try.",
            "image": "",
            "next": [
              {
                "id": 1002,
                "question":
                    "Activate zen mode with meditation, & deep breathing 🧘‍♀️",
                "image": "",
              },
              {
                "id": 1003,
                "question": "",
                "image": LocalImages.thanAdvide,
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 21,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 987,
            "text": "Thanks for the advice!",
            "image": "",
            "next": [
              {
                "id": 1098,
                "question": "Do you want to know what phase you are in?",
                "image": "",
              },
            ]
          },
        ]
      }
    ],
    [
      {
        "id": 22,
        "question": "What type of music do you enjoy?",
        "image": "",
        "answers": [
          {
            "id": 1004,
            "text": "Yes",
            "image": "",
            "next": [
              {
                "id": 1005,
                "question": "Welcome to  the cycle’s theatre! 🎬",
                "image": "",
              },
              {
                "id": 1006,
                "question": "",
                "image": LocalImages.urinTest,
              },
            ]
          },
        ]
      }
    ],
  ];

  int currentQuestionGroupIndex = 0;
  double sizeOfContainer = 50;
  int currentQuestionIndex = 0;
  String name = globalUserMaster?.name ?? '';
  @override
  void initState() {
    super.initState();
    // Start the conversation with the first question
    initilStateUpdate();
  }

  Future<void> initilStateUpdate() async {
    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: 'Hello ${name}', isUser: false, person: "Alice", image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text:
            'Track your periods, monitor your wellness, and get personalised health tips.',
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: 'Let s start your health journey!',
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: 'Listen to your body today, you are on Day 1 of your cycle.',
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: 'Do you want to know what’s going on in your body today?',
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });

    _messages.add(Message(
        text: questionsTree[currentQuestionGroupIndex][currentQuestionIndex]
            ["question"],
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: "", isUser: false, person: "Alice", image: LocalImages.chat1));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
    _messages.add(Message(
        text: 'Do you want to know what’s going on in your body today?',
        isUser: false,
        person: "Alice",
        image: ""));
    setState(() {
      isAnsSelected = true;
    });
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isAnsSelected = false;
    });
  }

  Future<void> _selectAnswer(String answerText) async {
    setState(() {
      isAnsSelected = true;
      _scrollController.animateTo(
        _scrollController.offset +
            300, // Change this value to scroll more or less
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      isAnsSelected = false;
      // Add the user's answer to the chat
      _messages.add(
          Message(text: answerText, isUser: true, person: "You", image: ""));

      // Find the current question and answer
      var currentGroup = questionsTree[currentQuestionGroupIndex];
      var currentQuestion = currentGroup[currentQuestionIndex];

      for (var answer in currentQuestion["answers"]) {
        if (answer["text"] == answerText) {
          // Add the next questions with images
          for (var nextQuestion in answer["next"]) {
            print("ID====================");
            print(nextQuestion["id"]);
            print("    ID====================");

            if (nextQuestion["id"] == 271) {
              _messages.add(Message(
                text:
                    "You might feel like a sleepy cat 🐱 because of hormonal changes and blood loss. It's totally normal to feel more tired and less energetic. Cat naps, anyone?",
                image: "",
                isUser: false,
                person: "Alice",
              ));
            } else if (nextQuestion["id"] == 272) {
              _messages.add(Message(
                text: "That sounds good. Thanks for sharing.",
                image: "",
                isUser: false,
                person: "Alice",
              ));
            } else if (nextQuestion["id"] == 276) {
              _messages.add(Message(
                text: "Noted.",
                image: "",
                isUser: false,
                person: "Alice",
              ));
            } else if (nextQuestion["id"] == 311) {
              _messages.add(Message(
                text: "Thanks for sharing!.",
                image: "",
                isUser: false,
                person: "Alice",
              ));
            } else if (nextQuestion["id"] == 315) {
              _messages.add(Message(
                text: "Here’s the menu:",
                image: "",
                isUser: false,
                person: "Alice",
              ));
            }
            _messages.add(Message(
              text: nextQuestion["question"],
              image: nextQuestion["image"],
              isUser: false,
              person: "Alice",
            ));
          }

          // Move to the next question group or reset if at the end
          if (currentQuestionGroupIndex < questionsTree.length - 1) {
            currentQuestionGroupIndex++; // Move to the next group
            currentQuestionIndex = 0; // Reset to the first question
          } else {
            // If we reached the last question group, we don't increment
            currentQuestionIndex++;
            if (currentQuestionIndex >=
                questionsTree[currentQuestionGroupIndex].length) {
              currentQuestionIndex =
                  0; // Reset to the first question if at the end
            }
          }
          break;
        }
      }

      // Optional: Handle end of questions
      if (currentQuestionGroupIndex >= questionsTree.length) {
        _messages.add(Message(
            text: "Thank you for chatting!", isUser: false, person: "Alice"));
      }
      // Scroll down by a specific offset
      _scrollController.animateTo(
        _scrollController.offset +
            300, // Change this value to scroll more or less
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _topImageAndText(answer, image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: OutlinedButton(
        onPressed: () {
          // Action when button is pressed
          _selectAnswer(answer);
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF6F4085)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

            // Rounded corners
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image.toString(),
              width: 40, // Width of the image
              height: 40,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 2),
            Text(
              answer,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _MainConatiner() {
    int id =
        questionsTree[currentQuestionGroupIndex][currentQuestionIndex]["id"];
    return Container(
      height: id == 3 || id == 4 || id == 5 || id == 7 || id == 10 || id == 11
          ? 150
          : 50,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: questionsTree[currentQuestionGroupIndex]
                  [currentQuestionIndex]["answers"]
              .length,
          itemBuilder: (context, index) {
            String answer = questionsTree[currentQuestionGroupIndex]
                [currentQuestionIndex]["answers"][index]["text"];
            String image = questionsTree[currentQuestionGroupIndex]
                [currentQuestionIndex]["answers"][index]["image"];
            // int id = questionsTree[currentQuestionGroupIndex]
            //     [currentQuestionIndex]["answers"][index]["id"];
            // if (id == 108 || id == 109 || id == 110) {
            //   sizeOfContainer = 100;
            // } else if (id == 101 || id == 105 || id == 105 || id == 106) {
            //   sizeOfContainer = 50;
            // }
            if (id == 3 ||
                id == 4 ||
                id == 5 ||
                id == 7 ||
                id == 10 ||
                id == 11) {
              return TextButton(
                onPressed: () {
                  // Action when button is pressed
                  _selectAnswer(answer);
                },
                child: Container(
                  // height: 80,
                  // width: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // width: 200, // Set desired width
                        // height: 200, // Set desired height
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 150, 146, 151), // Border color
                            width: 1, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // Match border radius
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Image.asset(
                              image.toString(),
                              width: 60, // Width of the image
                              height: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(width: 2),
                      Text(
                        answer,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: OutlinedButton(
                  onPressed: () {
                    // Action when button is pressed
                    _selectAnswer(answer);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Color.fromARGB(
                            255, 150, 146, 151)), // Outline color
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    // Padding
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (image.toString() != "")
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: image.toString() == ""
                              ? null
                              : Image.asset(
                                  image.toString(),
                                  width: 20, // Width of the image
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      SizedBox(width: 8),
                      Center(
                        child: Text(
                          answer,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTopImageSideButton() {
    return Container(
      constraints: BoxConstraints(maxHeight: 200, minHeight: 50.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: questionsTree[currentQuestionGroupIndex]
                [currentQuestionIndex]["answers"]
            .length,
        itemBuilder: (context, index) {
          String answer = questionsTree[currentQuestionGroupIndex]
              [currentQuestionIndex]["answers"][index]["text"];
          String image = questionsTree[currentQuestionGroupIndex]
              [currentQuestionIndex]["answers"][index]["image"];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: OutlinedButton(
              onPressed: () {
                // Action when button is pressed
                _selectAnswer(answer);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color(0xFF6F4085)), // Outline color
                // padding:
                //     EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                // Padding
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image.toString() != "")
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: image.toString() == ""
                          ? null
                          : Image.asset(
                              image.toString(),
                              width: 24, // Width of the image
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                    ),

                  SizedBox(width: 8),
                  // Text(
                  //   '😊', // Emoji
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  Text(
                    answer,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Column(
                  children: [
                    Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: (message.image.toString() != "")?BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xffF6F6F6), // Border color
                            width: 1, // Border width
                          ),
                        ):BoxDecoration(
                          color: message.isUser
                              ? Color(0xFF6F4085)
                              : Color(0xffF6F6F6),
                          borderRadius: message.isUser? BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(0), // Pointed end for sender bubble
                          ):BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: message.isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              message.text,
                              style: TextStyle(
                                  color: message.isUser
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            if (message.image.toString() != "")
                              GestureDetector(
                                onTap: () async{
                                  await showDialog(
                                  context: context,
                                  builder: (_) => FullScreenImageView(image: message.image??"",)
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: message.image.toString() == ""
                                      ? null
                                      : Image.asset(
                                          message.image.toString(),
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (isAnsSelected && index == _messages.length - 1)
                      Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 20),
                          child: Image.asset(
                            LocalImages.loadDots,
                            height: 59,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          // Display the answer options based on the current question

          if (_messages.isNotEmpty && !_messages.last.isUser) _MainConatiner()

          // isAnsSelected
        ],
      ),
    );
  }
}

class ImageDialog extends StatefulWidget {
  final String image;
  ImageDialog({super.key, required this.image});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(widget.image),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String image;

  const FullScreenImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // White background for the image
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow for cleaner look
      ),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: InteractiveViewer(
              maxScale: 5.0, // Maximum zoom scale
              child: Container(
                  color: Colors.white,
                  child: Image.asset(image)),//Image.network(image),
            ),
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final String? image; // Optional image for the message
  final bool isUser; // Indicates if the message is from the user or not
  final String person; // The name of the person sending the message

  Message(
      {required this.text,
      this.image,
      required this.isUser,
      required this.person});
}
