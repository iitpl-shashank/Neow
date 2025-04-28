import 'package:flutter/material.dart';

import '../../../models/mood_day_model.dart';

class Page4 extends StatefulWidget {
  Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool isWisheshDisplay = false;
  List<MoodDayModel> focusMonthList = [];
  List<MoodDayModel> golsList = [];
  List<MoodDayModel> hobbiesList = [];
  List<MoodDayModel> hobbitsToAdaptList = [];
  List<MoodDayModel> hobbitsToCutList = [];
  List<MoodDayModel> newThingsList = [];
  List<MoodDayModel> familyGoalsList = [];
  List<MoodDayModel> booksToReadList = [];
  List<MoodDayModel> moveToWatchList = [];
  List<MoodDayModel> placeToVisit = [];
  List<MoodDayModel> wisheshList = [];

  int _selectedYear = DateTime.now().year;
  String _selectedMonth = monthNames[DateTime.now().month - 1];

  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _selectedMonth = monthNames[DateTime.now().month - 1];
    loadtAllList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Monthly Mission - $_selectedMonth, $_selectedYear',
            style: TextStyle(color: Colors.black, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.black),
            onPressed: () {
              _showMonthYearPicker(context);
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Fcous of the Month",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                focusMonthList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(focusMonthList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.lerp(Color(0xFF6F4085), Colors.white, 0.9),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Goals",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                golsList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(golsList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Hobbies",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                hobbiesList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(hobbiesList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2FDFF),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Habits to cut",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                hobbitsToCutList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(hobbitsToCutList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF2FDFF),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "New things to try",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                newThingsList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(newThingsList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFAEEFF),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Family goals",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                familyGoalsList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(familyGoalsList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFBEE),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Books to read",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                booksToReadList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(booksToReadList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF1F1),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Movies to watch",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                moveToWatchList.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(moveToWatchList)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF7FFF4),
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
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/focus_month.png",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Places to visit",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Add item',
                              hintText: 'Enter item',
                              onSubmit: (value) {
                                //print('Input: $value'); // Do something with the input
                                placeToVisit.add(MoodDayModel(
                                    title: value, isSelected: false));
                                setState(() {});
                              },
                            );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    listFocusMonth(placeToVisit)
                  ],
                ),
              ),
              Visibility(
                visible: !isWisheshDisplay,
                child: GestureDetector(
                    onDoubleTap: () {
                      // Action to perform on double tap
                      print("Container double tapped!");
                      isWisheshDisplay = true;
                      setState(() {});
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: const BorderSide(
                          color: Color(0xFFAA99FF), // Light purple border color
                          width: 1.0,
                        ),
                      ),
                      elevation: 0, // Flat design as shown in image
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Make a wish',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/wish_1.png',
                                    // Make sure to add your image to assets
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Double tap and make your wish',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Visibility(
                visible: isWisheshDisplay,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF7FFF4),
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
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/focus_month.png",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Wishesh",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              showInputDialog(
                                context: context,
                                title: 'Add item',
                                hintText: 'Enter item',
                                onSubmit: (value) {
                                  //print('Input: $value'); // Do something with the input
                                  wisheshList.add(MoodDayModel(
                                      title: value, isSelected: false));
                                  setState(() {});
                                },
                              );
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.purple[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      listFocusMonth(wisheshList)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity, //
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Purple background
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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
      ),
    );
  }

  Widget _buildSection(
      String title, String emoji, Color backgroundColor, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Text(emoji, style: const TextStyle(fontSize: 16)),
                    Image.asset(
                      emoji,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildGoalItem(String text,
      {String? status, bool isCompleted = false}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                if (status != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        color: isCompleted ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                Switch(
                  value: isCompleted,
                  onChanged: (bool value) {},
                  activeColor: Colors.green,
                  activeTrackColor: Colors.green.withOpacity(0.5),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.withOpacity(0.6),
                  trackOutlineWidth: const MaterialStatePropertyAll(0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild(
      MoodDayModel item, List<MoodDayModel> parentList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 16),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Text(
                item.title ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  // Handle the click event
                  //print('Image clicked!');
                  parentList[index].isSelected =
                      !(parentList[index].isSelected ?? false);
                  setState(() {});
                },
                child: Image.asset(
                  (item.isSelected ?? false)
                      ? 'assets/images/toggle_switch_on.png'
                      : 'assets/images/toggle_switch.png',
                  // Path to your image
                  width: 35, // Optional width
                  height: 20, // Optional height
                  fit: BoxFit.fill, // Optional image fit
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listFocusMonth(List<MoodDayModel> focusMonthList) {
    return Column(
        children: List.generate(focusMonthList.length, (index) {
      return Column(
        children: [
          _buildChild(focusMonthList[index], focusMonthList, index),
        ],
      );
    }));
  }

  void loadtAllList() {
    focusMonthList.add(MoodDayModel(
        title: 'Read 10 pages a day', imagePath: "", isSelected: false));
    golsList.add(MoodDayModel(
        title: 'Lose weight - 2kgs', imagePath: "", isSelected: false));
    hobbiesList
        .add(MoodDayModel(title: 'Painting', imagePath: "", isSelected: false));
    hobbitsToAdaptList
        .add(MoodDayModel(title: 'Reading', imagePath: "", isSelected: false));
    hobbitsToCutList
        .add(MoodDayModel(title: 'Alcohol', imagePath: "", isSelected: false));
    newThingsList.add(
        MoodDayModel(title: 'Paste Recipe', imagePath: "", isSelected: false));
    familyGoalsList
        .add(MoodDayModel(title: 'Add', imagePath: "", isSelected: false));
    booksToReadList
        .add(MoodDayModel(title: 'Add', imagePath: "", isSelected: false));
    moveToWatchList
        .add(MoodDayModel(title: 'Add', imagePath: "", isSelected: false));
    placeToVisit
        .add(MoodDayModel(title: 'Add', imagePath: "", isSelected: false));
    wisheshList
        .add(MoodDayModel(title: 'Wish1', imagePath: "", isSelected: false));
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

  void _showMonthYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String localSelectedMonth = _selectedMonth;
        int localSelectedYear = _selectedYear;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Month and Year',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Year Dropdown (current year to 5 future years)
                  DropdownButton<int>(
                    value: localSelectedYear,
                    items: List.generate(6, (index) {
                      int year = DateTime.now().year +
                          index; // Current year to 5 future years
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (value) {
                      setDialogState(() {
                        localSelectedYear = value!;
                        // Reset the month list when year is changed
                        if (localSelectedYear == DateTime.now().year) {
                          // If selecting current year, show months from current month onward
                          localSelectedMonth =
                              monthNames[DateTime.now().month - 1];
                        } else {
                          // If selecting a future year, show all months
                          localSelectedMonth =
                              monthNames[0]; // Start from January
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  // Month Dropdown (current month to December of selected year)
                  DropdownButton<String>(
                    value: localSelectedMonth,
                    items: (localSelectedYear == DateTime.now().year
                            ? List.generate(12 - (DateTime.now().month - 1),
                                (index) {
                                return monthNames[
                                    DateTime.now().month - 1 + index];
                              })
                            : monthNames)
                        .map((month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        localSelectedMonth = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    setState(() {
                      _selectedYear = localSelectedYear;
                      _selectedMonth = localSelectedMonth;
                    });

                    // Show selected month and year
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Selected: $_selectedMonth, $_selectedYear',
                        ),
                      ),
                    );*/
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
