import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/mood_day_model.dart';
import '../calendar/weekly_calendar_daily_diary.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<MoodDayModel> musicList = [];
  List<MoodDayModel> acadamicList = [];
  List<MoodDayModel> cleaningList = [];
  List<MoodDayModel> bodyCareList = [];
  List<MoodDayModel> gratitudeList = [];
  List<MoodDayModel> sleepList = [];
  List<MoodDayModel> hangoutList = [];
  List<MoodDayModel> workoutList = [];
  List<MoodDayModel> screenTimeList = [];
  List<MoodDayModel> foodList = [];
  List<MoodDayModel> dailyActivityList = [];
  List<MoodDayModel> todoList = [];
  List<MoodDayModel> moodDayList = [];
  List<MoodDayModel> topActivityList = [];
  String selectedMonth = "";

  @override
  void initState() {
    super.initState();
    loadtAllList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text('My Daily Diary',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.black),
            onPressed: () {
              /*  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page2()),
              );*/
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/frame_1.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          selectedMonth,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff222B45)),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        decoration: BoxDecoration(
                          //color: isToday ? Colors.blueAccent : Colors.transparent,
                          //color: Color(0xFFF0E3FF), //Colors.blueAccent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Color(0xff222B45), width: 1.5),
                        ),
                        child: Text(
                          'Report Card',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  WeeklyCalendar(
                    calendarDates: _getDatesFromMonday(),
                    specialDates: {
                      DateTime.parse("2024-12-30"),
                      DateTime.parse("2024-12-27"),
                      DateTime.parse("2024-12-25"),
                      DateTime.parse("2025-01-01"),
                      DateTime.parse("2025-01-05"),
                    },
                    selectedDate: (selectedDate, month) {
                      selectedMonth = month;
                      setState(() {});
                    },
                    onScrollMonth: (month) {
                      selectedMonth = month;
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 10,
                ),
                children: [
                  _buildActivityItem(
                    topActivityList[0].title ?? "",
                    topActivityList[0].imagePath ?? "",
                    //'assets/images/music.png',
                    onTap: () => _showCustomPopup(context, musicList,
                        0), //_showSnackBar(context, 'Music'),
                  ),
                  _buildActivityItem(topActivityList[1].title ?? "",
                      topActivityList[1].imagePath ?? "",
                      onTap: () =>
                          {_showCustomPopup(context, acadamicList, 1)}),
                  _buildActivityItem(
                    topActivityList[2].title ?? "",
                    topActivityList[2].imagePath ?? "",
                    /*'Cleaning',
                    'assets/images/cleaning.png',*/
                    onTap: () => {_showCustomPopup(context, cleaningList, 2)},
                  ),
                  _buildActivityItem(
                    /*'Body care',
                    'assets/images/body_care.png',*/
                    topActivityList[3].title ?? "",
                    topActivityList[3].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, bodyCareList, 3)},
                  ),
                  _buildActivityItem(
                    /*'Gratitude',
                    'assets/images/gratitude.png',
                    onTap: () => {},*/
                    topActivityList[4].title ?? "",
                    topActivityList[4].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, gratitudeList, 4)},
                  ),
                  _buildActivityItem(
                    /*'Sleep',
                    'assets/images/sleep.png',
                    onTap: () => {},*/
                    topActivityList[5].title ?? "",
                    topActivityList[5].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, sleepList, 5)},
                  ),
                  _buildActivityItem(
                    /* 'Hangout',
                    'assets/images/hangout.png',
                    onTap: () => {},*/
                    topActivityList[6].title ?? "",
                    topActivityList[6].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, hangoutList, 6)},
                  ),
                  _buildActivityItem(
                    /* 'Workout',
                    'assets/images/workout.png',
                    onTap: () => {},*/
                    topActivityList[7].title ?? "",
                    topActivityList[7].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, workoutList, 7)},
                  ),
                  _buildActivityItem(
                    /*'Screen time',
                    'assets/images/screen_time.png',
                    onTap: () => {},*/
                    topActivityList[8].title ?? "",
                    topActivityList[8].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, screenTimeList, 8)},
                  ),
                  _buildActivityItem(
                    /*'Food',
                    'assets/images/food_1.png',
                    onTap: () => {},*/
                    topActivityList[9].title ?? "",
                    topActivityList[9].imagePath ?? "",
                    onTap: () => {_showCustomPopup(context, foodList, 9)},
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  // Purple shadow on the left
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mood of the day',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            for (int i = 0; i < (moodDayList.length); i++) {
                              moodDayList[i].isSelected = false;
                            }
                            moodDayList[0].isSelected = true;
                            setState(() {});
                          },
                          child: _buildMoodItem(moodDayList[0])),
                      InkWell(
                          onTap: () {
                            for (int i = 0; i < (moodDayList.length); i++) {
                              moodDayList[i].isSelected = false;
                            }
                            moodDayList[1].isSelected = true;
                            setState(() {});
                          },
                          child: _buildMoodItem(moodDayList[1])),
                      InkWell(
                          onTap: () {
                            for (int i = 0; i < (moodDayList.length); i++) {
                              moodDayList[i].isSelected = false;
                            }
                            moodDayList[2].isSelected = true;
                            setState(() {});
                          },
                          child: _buildMoodItem(moodDayList[2])),
                      InkWell(
                          onTap: () {
                            for (int i = 0; i < (moodDayList.length); i++) {
                              moodDayList[i].isSelected = false;
                            }
                            moodDayList[3].isSelected = true;
                            setState(() {});
                          },
                          child: _buildMoodItem(moodDayList[3])),
                      InkWell(
                          onTap: () {
                            for (int i = 0; i < (moodDayList.length); i++) {
                              moodDayList[i].isSelected = false;
                            }
                            moodDayList[4].isSelected = true;
                            setState(() {});
                          },
                          child: _buildMoodItem(moodDayList[4])),
                    ],
                  ),
                  // listMoodOfTheDayView(moodDayList),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMoodItem(
                          'Rock on!', 'assets/images/angry_1.png', true),
                      _buildMoodItem('Sad', 'assets/images/sad_1.png', false),
                      _buildMoodItem(
                          'Bored', 'assets/images/bored_1.png', false),
                      _buildMoodItem(
                          'Angry', 'assets/images/rock_on_1.png', false),
                      _buildMoodItem(
                          'Tired', 'assets/images/Tired_1.png', false),
                    ],
                  ),*/
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  // Purple shadow on the left
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily activities',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle add button tap
                            showInputDialog(
                              context: context,
                              title: 'Add Activity',
                              hintText: 'Enter activity',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                dailyActivityList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.purple,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  listDailyActivityView(dailyActivityList),
                  /*_buildDailyActivityItem('Yoga', false),
                  const Divider(height: 1, indent: 40,),
                  _buildDailyActivityItem('Workout', false),
                  const Divider(height: 1, indent: 40,),*/
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  // Purple shadow on the left
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(-5, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'To-do list',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle add button tap
                            showInputDialog(
                              context: context,
                              title: 'Add Todo Item',
                              hintText: 'Enter todo item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                todoList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.purple,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  listTodoListView(todoList),
                  /*_buildDailyActivityItem('Yoga', true),
                  const Divider(
                    height: 1,
                    indent: 40,
                  ),
                  _buildDailyActivityItem('Workout', true),
                  const Divider(
                    height: 1,
                    indent: 40,
                  ),*/
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity, //
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Purple background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  //Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String label, String imagePath,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 40,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMoodItem(MoodDayModel item) {
    //(String label, String imagePath, bool isSelected) {
    return Container(
      width: 55,
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: (item.isSelected ?? false)
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.white, // White background color
              shape: BoxShape.circle, // Circular shape
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            // Padding inside the circle
            child: ClipOval(
              child: Image.asset(
                item.imagePath ?? "",
                //width: 100, // Optional width
                //height: 100, // Optional height
                fit: BoxFit.contain, // Optional fit to scale the image
              ),
            ),
          ),

          /*Image.asset(
            item.imagePath??"",
            width: 60,
            height: 60,
          ),*/
          SizedBox(
            height: 10,
          ),
          Text(
            item.title ?? "",
            style: TextStyle(
              fontSize: 12,
              fontWeight: (item.isSelected ?? false)
                  ? FontWeight.w600
                  : FontWeight.w400,
              color: (item.isSelected ?? false)
                  ? Color(0xff6F4085)
                  : Color(0xff111111),
            ),
          ),
        ],
      ),
    );
  }

  Widget listMoodOfTheDayView(List<MoodDayModel> moodList) {
    return Row(
        children: List.generate(moodList.length, (index) {
      return Column(
        children: [
          InkWell(
              onTap: () {
                for (int i = 0; i < (moodList.length); i++) {
                  moodList[i].isSelected = false;
                }
                moodList[index].isSelected = true;
                setState(() {});
              },
              child: _buildMoodItem(moodList[index])),
        ],
      );
    }));
  }

  Widget listDailyActivityView(List<MoodDayModel> dailyActivities) {
    return Column(
        children: List.generate(dailyActivities.length, (index) {
      return Column(
        children: [
          _buildDailyActivityItem(dailyActivities[index], false, index),
          const Divider(
            height: 1,
            indent: 40,
          ),
        ],
      );
    }));
  }

  Widget listTodoListView(List<MoodDayModel> todoList) {
    return Column(
        children: List.generate(todoList.length, (index) {
      return Column(
        children: [
          _buildDailyActivityItem(todoList[index], true, index),
          const Divider(
            height: 1,
            indent: 40,
          ),
        ],
      );
    }));
  }

  Widget _buildDailyActivityItem(MoodDayModel item, bool isToggle, int index) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.purple,
                  //use conditiion
                  width: 2,
                ),
              ),
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 6,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              item.title ?? "",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isToggle)
              InkWell(
                onTap: () {
                  // Handle the click event
                  //print('Image clicked!');
                  todoList[index].isSelected =
                      !(todoList[index].isSelected ?? false);
                  setState(() {});
                },
                child: Image.asset(
                  (item.isSelected ?? false)
                      ? 'assets/images/switch_todo_on.png'
                      : 'assets/images/switch_todo_off.png',
                  // Path to your image
                  width: 60, // Optional width
                  height: 30, // Optional height
                  fit: BoxFit.cover, // Optional image fit
                ),
              )
          ],
        ),
      ),
    );
  }

  void showInputDialog({
    required BuildContext context,
    required String title,
    String? hintText,
    required Function(String) onSubmit,
  }) {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(
                color: Color(0xff575757),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.purple,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(-5, 0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, // Removes the default border
              ),
            ),
          ),
          actions: [
            Center(
              // Center the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Purple background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    onSubmit(textController.text);
                  }
                  setState(() {});
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageColumn(MoodDayModel item) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: (item.isSelected ?? false)
                ? Colors.grey.withOpacity(0.1)
                : Colors.white, // White background color
            shape: BoxShape.circle, // Circular shape
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Image.asset(item.imagePath ?? "assets/images/lound_second.png",
              width: 64, height: 64),
        ), // Replace with actual image paths
        SizedBox(height: 10),
        Text(item.title ?? "", style: TextStyle(fontSize: 14)),
      ],
    );
  }

  void _showCustomPopup(BuildContext context, List<MoodDayModel> itemList,
      int selectedParentIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return LayoutBuilder(builder: (context, constraints) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: EdgeInsets.zero, // Removes default padding
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Add space below close icon
                      SizedBox(height: 40),
                      // Content Row
                      Wrap(
                        spacing: 16, // Horizontal spacing between items
                        runSpacing: 16, // Vertical spacing between rows
                        alignment: WrapAlignment.center,
                        children: List.generate(itemList.length, (index) {
                          return InkWell(
                              onTap: () {
                                for (int i = 0; i < (itemList.length); i++) {
                                  itemList[i].isSelected = false;
                                }
                                itemList[index].isSelected = true;
                                //this below line updating parent view
                                topActivityList[selectedParentIndex].imagePath =
                                    itemList[index].imagePath ?? "";
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: _buildImageColumn(itemList[index]));
                        }),
                        /*children: [
                          _buildImageColumn(itemList[0]),
                          _buildImageColumn(itemList[1]),
                          _buildImageColumn(itemList[2]),
                        ],*/
                      ),
                    ],
                  ),
                ),
                // Close Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void loadtAllList() {
    topActivityList.add(MoodDayModel(
        title: 'Music',
        imagePath: "assets/images/music.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Learning',
        imagePath: "assets/images/learning.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Cleaning',
        imagePath: "assets/images/cleaning.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Body care',
        imagePath: "assets/images/body_care.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Gratitude',
        imagePath: "assets/images/gratitude.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Sleep',
        imagePath: "assets/images/sleep.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Hangout',
        imagePath: "assets/images/hangout.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Workout',
        imagePath: "assets/images/workout.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Screen time',
        imagePath: "assets/images/screen_time.png",
        isSelected: false));
    topActivityList.add(MoodDayModel(
        title: 'Food',
        imagePath: "assets/images/food_1.png",
        isSelected: false));

    dailyActivityList.add(MoodDayModel(title: 'Yoga', isSelected: false));
    dailyActivityList.add(MoodDayModel(title: 'Workout', isSelected: false));

    todoList.add(MoodDayModel(title: 'Yoga', isSelected: false));
    todoList.add(MoodDayModel(title: 'Workout', isSelected: false));

    musicList.add(MoodDayModel(
        title: 'Soulful',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));
    musicList.add(MoodDayModel(
        title: 'Loud',
        imagePath: "assets/images/mix_second.png",
        isSelected: false));
    musicList.add(MoodDayModel(
        title: 'Spiritul',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));
    musicList.add(MoodDayModel(
        title: 'Loud',
        imagePath: "assets/images/mix_second.png",
        isSelected: false));
    musicList.add(MoodDayModel(
        title: 'None',
        imagePath: "assets/images/mix_second.png",
        isSelected: false));

    acadamicList.add(MoodDayModel(
        title: 'Academic',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));
    acadamicList.add(MoodDayModel(
        title: 'Non-Academic',
        imagePath: "assets/images/mix_second.png",
        isSelected: false));
    acadamicList.add(MoodDayModel(
        title: 'None',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    cleaningList.add(MoodDayModel(
        title: 'Room/bed',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    cleaningList.add(MoodDayModel(
        title: 'Study Table/Cupboard',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    cleaningList.add(MoodDayModel(
        title: 'Outdoors',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    cleaningList.add(MoodDayModel(
        title: 'None',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    cleaningList.add(MoodDayModel(
        title: 'All',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    bodyCareList.add(MoodDayModel(
        title: 'Basic',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    bodyCareList.add(MoodDayModel(
        title: 'Pamper',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    bodyCareList.add(MoodDayModel(
        title: 'Spa',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    bodyCareList.add(MoodDayModel(
        title: 'None',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    gratitudeList.add(MoodDayModel(
        title: 'Yes',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    gratitudeList.add(MoodDayModel(
        title: 'No',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    sleepList.add(MoodDayModel(
        title: 'Sound',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    sleepList.add(MoodDayModel(
        title: 'Night Owl',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    sleepList.add(MoodDayModel(
        title: 'Early Riser',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    sleepList.add(MoodDayModel(
        title: 'Oversleep',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    sleepList.add(MoodDayModel(
        title: 'Irritated',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    hangoutList.add(MoodDayModel(
        title: 'Gym/Aerrobics',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    hangoutList.add(MoodDayModel(
        title: 'Sports',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    hangoutList.add(MoodDayModel(
        title: 'Yoga',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    hangoutList.add(MoodDayModel(
        title: 'Walk',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    hangoutList.add(MoodDayModel(
        title: 'None',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    workoutList.add(MoodDayModel(
        title: 'Mall',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    workoutList.add(MoodDayModel(
        title: 'Cafe',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    workoutList.add(MoodDayModel(
        title: 'Park',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    workoutList.add(MoodDayModel(
        title: 'Party',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    workoutList.add(MoodDayModel(
        title: 'Binge-watch',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    screenTimeList.add(MoodDayModel(
        title: '>2 hrs',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    screenTimeList.add(MoodDayModel(
        title: '3-4 hrs',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    screenTimeList.add(MoodDayModel(
        title: '5-6 hrs',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    screenTimeList.add(MoodDayModel(
        title: '8 hrs',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    screenTimeList.add(MoodDayModel(
        title: '10 hrs+',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    foodList.add(MoodDayModel(
        title: 'Unhealthy',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    foodList.add(MoodDayModel(
        title: 'Healthy',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    foodList.add(MoodDayModel(
        title: 'Liquor',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    foodList.add(MoodDayModel(
        title: 'Intermittent',
        imagePath: "assets/images/lound_second.png",
        isSelected: false));

    moodDayList.add(MoodDayModel(
        title: 'Rock on!',
        imagePath: 'assets/images/angry_1.png',
        isSelected: true));
    moodDayList.add(MoodDayModel(
        title: 'Sad', imagePath: 'assets/images/sad_1.png', isSelected: false));
    moodDayList.add(MoodDayModel(
        title: 'Bored',
        imagePath: 'assets/images/bored_1.png',
        isSelected: false));
    moodDayList.add(MoodDayModel(
        title: 'Angry',
        imagePath: 'assets/images/rock_on_1.png',
        isSelected: false));
    moodDayList.add(MoodDayModel(
        title: 'Tired',
        imagePath: 'assets/images/Tired_1.png',
        isSelected: false));
  }

  List<DateTime> _getDatesFromMonday() {
    DateTime today = DateTime.now();
    int daysToMonday = (today.weekday - 1) % 7;
    DateTime startFromMonday = today.subtract(Duration(days: daysToMonday));

    // Generate 50 days from the start date
    return List<DateTime>.generate(
        50, (index) => startFromMonday.add(Duration(days: index)));
  }
}
