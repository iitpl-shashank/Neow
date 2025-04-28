import 'package:flutter/material.dart';

class WeeklyCalendar extends StatefulWidget {
  final List<DateTime> calendarDates;
  final Set<DateTime> specialDates;
  Function(String selectedDate, String month) selectedDate;
  Function(String month) onScrollMonth;

  WeeklyCalendar(
      {required this.calendarDates,
      required this.specialDates,
      required this.onScrollMonth,
      required this.selectedDate});

  @override
  _WeeklyCalendarState createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  late PageController _pageController;
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.15);
    _currentMonth = widget.calendarDates[0];
    _selectedDate = widget.calendarDates[0]; // Default to the first date
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    // Update the month when the user scrolls
    int index = _pageController.page!.round();
    DateTime selectedDate = widget.calendarDates[index];
    _currentMonth = DateTime(selectedDate.year, selectedDate.month);
    widget.onScrollMonth(
        "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),*/
        SizedBox(
          height: 120, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.calendarDates.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              DateTime date = widget.calendarDates[index];
              bool isSpecial = _isSpecialDate(date);
              bool isToday = _isToday(date);
              bool isSelected = _selectedDate
                  .isAtSameMomentAs(date); // Check if this date is selected
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date; // Update selected date when tapped
                      widget.selectedDate(_selectedDate.toString(),
                          "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}");
                      print("selected Date weekly daily diary: $_selectedDate");
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular Background for Day Initial (if today)
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: isToday
                            ? BoxDecoration(
                                //color: isToday ? Colors.blueAccent : Colors.transparent,
                                color: Color(0xFFF0E3FF), //Colors.blueAccent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1.5),
                              )
                            : BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.rectangle),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                _dayInitial(date),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isToday ? Colors.black : Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Circular Background for Date
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isToday
                                    ? Color(0xFF6F4085)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isToday ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Dot for Special Day
                      if (isSpecial)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Color(0xFFBBBBBB),
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (!isSpecial) Container(width: 8, height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _dayInitial(DateTime date) {
    // Get the day initial (e.g., "M" for Monday)
    return ['M', 'T', 'W', 'T', 'F', 'S', 'S'][date.weekday % 7];
  }

  bool _isSpecialDate(DateTime date) {
    // Compare dates without time components
    return widget.specialDates.any((specialDate) =>
        specialDate.year == date.year &&
        specialDate.month == date.month &&
        specialDate.day == date.day);
  }

  bool _isToday(DateTime date) {
    // Check if the date is today
    DateTime now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  String _getMonthName(int month) {
    const monthNames = [
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
      'December'
    ];
    return monthNames[month - 1];
  }
}
