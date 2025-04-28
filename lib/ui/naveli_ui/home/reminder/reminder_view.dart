import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.reminder,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Image.asset(
                    LocalImages.img_mobile,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    S.of(context)!.getReminder,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.piedra(
                      color: CommonColors.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    S.of(context)!.stayYourPeriod,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.piedra(
                      color: CommonColors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: PrimaryButton(
                    width: MediaQuery.of(context).size.width / 2,
                    label: S.of(context)!.next,
                    borderRadius: BorderRadius.circular(50),
                    onPress: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        builder: (BuildContext? context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context!)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        // Get the current date and time
                        DateTime now = DateTime.now();

                        // Create a DateTime object for the scheduled time
                        DateTime scheduledTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          picked.hour,
                          picked.minute,
                        );

                        // If the scheduled time is before the current time, show the notification instantly
                        if (scheduledTime.isBefore(now)) {
                          // Schedule the notification for the next minute to show instantly
                          scheduledTime = now.add(const Duration(minutes: 1));
                        }

                        // Make sure to call this method before using any timezone-related functions
                        tzdata.initializeTimeZones();

                        // Assuming you have the correct timezone identifier as a string
                        String timezoneIdentifier =
                            'Asia/Kolkata'; // Ahmedabad timezone

                        // Get the location using the identifier
                        tz.Location timezoneLocation =
                            tz.getLocation(timezoneIdentifier);

                        // Now you can pass the timezone location to the NotificationCalendar
                        AwesomeNotifications().createNotification(
                          content: NotificationContent(
                            id: 0,
                            channelKey: 'basic_channel',
                            // Ensure this matches your channel key
                            title: 'Reminder about your cycle',
                            body: 'It\'s time!',
                          ),
                          schedule: NotificationCalendar(
                            year: scheduledTime.year,
                            month: scheduledTime.month,
                            day: scheduledTime.day,
                            hour: scheduledTime.hour,
                            minute: scheduledTime.minute,
                            second: 0,
                            // Set seconds to 0 for precision
                            millisecond: 0,
                            timeZone: timezoneLocation.name,
                            // Pass the timezone name
                            allowWhileIdle:
                                true, // Allow the notification to be shown even if the device is idle
                          ),
                        );

                        print('Notification scheduled at $scheduledTime');

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Main Wapas Aunga!\nMain Wapas Aunga!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.piedra(
                                      color: CommonColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    LocalImages.img_vapas_aaunga,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height /
                                        3.5,
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pop(context);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
