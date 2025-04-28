import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/models/date_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'monthly_reminders_view_model.dart';

class Page5 extends StatefulWidget {
  Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  DateTime now = DateTime.now();
  late MonthlyRemindersViewModel mMonthlReminderViewModel;

  @override
  void initState() {
    super.initState();
    mMonthlReminderViewModel = Provider.of<MonthlyRemindersViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      mMonthlReminderViewModel.attachedContext(context);
      mMonthlReminderViewModel.getMonthlyRemindersList().whenComplete(() {
        setState(() {

        });
      });
    });
  }

  void _showAddReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddReminderDialog(onReminderAdded: (data) {
        if (mMonthlReminderViewModel.meetingList.isEmpty) {
          print("list empty blue");
          data.color = Colors.blue;
        } else if (mMonthlReminderViewModel.meetingList.length == 1) {
          print("list empty blue");
          data.color = Colors.red;
        } else if (mMonthlReminderViewModel.meetingList.length % 2 == 0) {
          data.color = Colors.red;
          print("list red");
        } else {
          data.color = Colors.blue;
          print("list blue ${mMonthlReminderViewModel.meetingList.length} / ${mMonthlReminderViewModel.meetingList.length / 2}");
        }
        mMonthlReminderViewModel.meetingList.add(data);
        setState(() {});
      }, mMonthlReminderViewModel: mMonthlReminderViewModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Monthly Reminders',
            style: TextStyle(color: Colors.black, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SfCalendar(
        view: CalendarView.week,
        showDatePickerButton: true,
        dataSource: MeetingDataSource(mMonthlReminderViewModel.meetingList),
        todayHighlightColor: Colors.blue,
        /*appointmentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),*/
        appointmentBuilder:
            (BuildContext context, CalendarAppointmentDetails details) {
          final Appointment appointment = details.appointments.first;

          // Check for birthday event
          if (appointment.subject.contains('Birthday Party')) {
            return Container(
              decoration: BoxDecoration(
                color: appointment.color.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add an Icon or Image
                  Icon(
                    Icons.cake,
                    color: Colors.white,
                    size: 15,
                  ),
                  // Use an icon
                  // Or use an image:
                  // Image.asset('assets/birthday_cake.png', height: 24, width: 24),
                  const SizedBox(width: 8),
                  // Add the text
                  Expanded(
                    child: Text(
                      appointment.subject.replaceAll('Birthday Party_', ""),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Default rendering for other appointments
          return Container(
            color: appointment.color,
            child: Center(
              child: Text(
                appointment.subject,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddReminderDialog(context),
        backgroundColor: Colors.purple,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

}

class AddReminderDialog extends StatefulWidget {
  Function(Appointment data) onReminderAdded;
  MonthlyRemindersViewModel mMonthlReminderViewModel;
  AddReminderDialog({super.key, required this.onReminderAdded, required this.mMonthlReminderViewModel});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final TextEditingController _reminderController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _headerDisplayMonth = monthNames[DateTime.now().month - 1];
  int _headerDisplayYear = DateTime.now().year;
  DateTime _targetDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isBirthday = false;

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
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFF0F0F0), //Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // Month and Year
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  '$_headerDisplayMonth, $_headerDisplayYear',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    _goToPreviousMonth();
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    _goToNextMonth();
                  },
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Calendar
            Container(
              height: 280,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: CalendarCarousel(
                showHeader: false,
                selectedDateTime: _selectedDate,
                targetDateTime: _targetDate,
                weekendTextStyle: const TextStyle(color: Colors.black),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                selectedDayButtonColor: Colors.purple,
                selectedDayBorderColor: Colors.purple,
                showHeaderButton: true,
                weekdayTextStyle: const TextStyle(color: Colors.black),
                firstDayOfWeek: 0,
                // Sunday
                customWeekDayBuilder: (weekday, weekdayName) {
                  return Center(
                    child: Text(
                      weekdayName.substring(0, 1),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() {
                    _selectedDate = date;
                    _headerDisplayYear = _selectedDate.year;
                    _headerDisplayMonth = monthNames[_selectedDate.month - 1];
                  });
                },
                onCalendarChanged: (date) {
                  setState(() {
                    _targetDate = date;
                  });
                },
              ),
            ),
            // Time Picker Section
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                children: [
                  Text(
                    "Birthday event",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      isBirthday = !isBirthday;
                      setState(() {});
                    },
                    child: Image.asset(
                      (isBirthday ?? false)
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
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
              child: Row(
                children: [
                  const Text('Choose Time:',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 10),
                  Text(
                    _selectedTime.format(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.purple),
                      child: const Text(
                        'Select Time',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Reminder Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Reminder:', style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _reminderController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  hintText: 'Enter reminder text',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add reminder logic here

                  print("timer=${_selectedTime.hour}");

                  var meetingStart = DateTime(
                    _selectedDate.year,
                    _selectedDate.month,
                    _selectedDate.day,
                    _selectedTime.hour,
                    _selectedTime.minute,
                  );

                  DateTime meetingEnd =
                      meetingStart.add(const Duration(hours: 1));
                  var subject = "";
                  if (isBirthday) {
                    subject = "Birthday Party_${_reminderController.text}";
                  } else {
                    subject = _reminderController.text;
                  }
                  widget.onReminderAdded(Appointment(
                      startTime: meetingStart,
                      //_selectedDate.add(Duration(days: 1, hours: 3)),
                      endTime: meetingEnd,
                      //_selectedDate.add(Duration(days: 1, hours: 4)),
                      subject: subject)); //_reminderController.text));
                  // Define the desired format
                  DateFormat outputFormat = DateFormat("dd-MMM-yyyy");
                  DateFormat timeFormat = DateFormat("hh:mm a");
                  // Format the DateTime object into the desired string
                  String formattedDate = outputFormat.format(meetingStart);
                  print("Formatted Date: $formattedDate"); // Output: 16-Dec-2025
                  Navigator.pop(context);
                  widget.mMonthlReminderViewModel.addMonthlyReminder(
                    date: formattedDate,
                    time: timeFormat.format(meetingStart),
                    title: subject,
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text(
                  'Add reminder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      _targetDate = DateTime(_targetDate.year, _targetDate.month - 1, 1);
      _headerDisplayYear = _targetDate.year;
      _headerDisplayMonth = monthNames[_targetDate.month - 1];
    });
  }

  void _goToNextMonth() {
    setState(() {
      _targetDate = DateTime(_targetDate.year, _targetDate.month + 1, 1);
      _headerDisplayYear = _targetDate.year;
      _headerDisplayMonth = monthNames[_targetDate.month - 1];
    });
  }

  @override
  void dispose() {
    _reminderController.dispose();
    super.dispose();
  }
}

// Custom data source for the calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
