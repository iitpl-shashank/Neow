import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/common_colors.dart';
import '../utils/gear_sound_service.dart';

/// Shows an authentic iOS-style rounded modal bottom sheet date picker with 3-wheel cylinder scroll
Future<DateTime?> showIosWheelDatePickerModal({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? minDate,
  DateTime? maxDate,
  String title = "Select Date of Birth",
  String cancelText = "Cancel",
  String doneText = "Done",
}) async {
  DateTime tempSelectedDate = initialDate ??
      DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

  return showModalBottomSheet<DateTime>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      return Container(
        decoration: const BoxDecoration(
          color: CommonColors.mWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top drag notch
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 4),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: CommonColors.greyShade,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // iOS Header: Cancel | Title | Done
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(ctx).pop(null);
                      },
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: CommonColors.greyText,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: CommonColors.blackColor,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(ctx).pop(tempSelectedDate);
                      },
                      child: Text(
                        doneText,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: CommonColors.divider),
              // 3-Wheel Cylinder Scroll Picker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: IosWheelDatePicker(
                  initialDate: tempSelectedDate,
                  minDate: minDate,
                  maxDate: maxDate,
                  onDateChanged: (DateTime date) {
                    tempSelectedDate = date;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class IosWheelDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final ValueChanged<DateTime> onDateChanged;
  final double height;

  IosWheelDatePicker({
    super.key,
    this.initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required this.onDateChanged,
    this.height = 220,
  })  : minDate = minDate ?? DateTime(1920, 1, 1),
        maxDate = maxDate ??
            DateTime(
                DateTime.now().year - 7, DateTime.now().month, DateTime.now().day);

  @override
  State<IosWheelDatePicker> createState() => _IosWheelDatePickerState();
}

class _IosWheelDatePickerState extends State<IosWheelDatePicker> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  final List<String> _months = const [
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

  late final List<int> _years;

  @override
  void initState() {
    super.initState();
    GearSoundService().init();

    _years = List.generate(
      widget.maxDate.year - widget.minDate.year + 1,
      (index) => widget.minDate.year + index,
    );

    DateTime init = widget.initialDate ??
        DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);

    if (init.isBefore(widget.minDate)) {
      init = widget.minDate;
    } else if (init.isAfter(widget.maxDate)) {
      init = widget.maxDate;
    }

    _selectedYear = init.year;
    _selectedMonth = init.month;
    _selectedDay = init.day;

    final yearIndex = _years.indexOf(_selectedYear).clamp(0, _years.length - 1);
    final monthIndex = (_selectedMonth - 1).clamp(0, 11);
    final dayIndex = (_selectedDay - 1).clamp(0, _daysInMonth(_selectedMonth, _selectedYear) - 1);

    _yearController = FixedExtentScrollController(initialItem: yearIndex);
    _monthController = FixedExtentScrollController(initialItem: monthIndex);
    _dayController = FixedExtentScrollController(initialItem: dayIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyDateChanged();
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  void _notifyDateChanged() {
    final maxDays = _daysInMonth(_selectedMonth, _selectedYear);
    if (_selectedDay > maxDays) {
      _selectedDay = maxDays;
      if (_dayController.hasClients) {
        _dayController.jumpToItem(_selectedDay - 1);
      }
    }

    DateTime candidate = DateTime(_selectedYear, _selectedMonth, _selectedDay);
    if (candidate.isBefore(widget.minDate)) {
      candidate = widget.minDate;
    } else if (candidate.isAfter(widget.maxDate)) {
      candidate = widget.maxDate;
    }
    _selectedYear = candidate.year;
    _selectedMonth = candidate.month;
    _selectedDay = candidate.day;

    widget.onDateChanged(candidate);
  }

  @override
  Widget build(BuildContext context) {
    final maxDays = _daysInMonth(_selectedMonth, _selectedYear);

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: CommonColors.mWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CommonColors.primaryColor.withAlpha(25),
          width: 1.0,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // iOS Selection Lens highlight overlay
          Container(
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: CommonColors.primaryLite.withAlpha(90),
              borderRadius: BorderRadius.circular(10),
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: CommonColors.primaryColor.withAlpha(65),
                  width: 1.2,
                ),
              ),
            ),
          ),
          // 3-Wheel Columns: Day | Month | Year
          Row(
            children: [
              // 1. Day Wheel
              Expanded(
                flex: 2,
                child: CupertinoPicker.builder(
                  scrollController: _dayController,
                  itemExtent: 44,
                  diameterRatio: 1.25,
                  squeeze: 1.18,
                  magnification: 1.12,
                  useMagnifier: true,
                  selectionOverlay: const SizedBox.shrink(),
                  childCount: maxDays,
                  onSelectedItemChanged: (index) {
                    GearSoundService().triggerGearFeedback();
                    setState(() {
                      _selectedDay = index + 1;
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isSelected = day == _selectedDay;
                    return Center(
                      child: Text(
                        day.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: isSelected ? 20 : 17,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? CommonColors.primaryColor
                              : CommonColors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Separator line
              Container(
                height: 100,
                width: 1,
                color: CommonColors.divider.withAlpha(140),
              ),
              // 2. Month Wheel
              Expanded(
                flex: 4,
                child: CupertinoPicker.builder(
                  scrollController: _monthController,
                  itemExtent: 44,
                  diameterRatio: 1.25,
                  squeeze: 1.18,
                  magnification: 1.12,
                  useMagnifier: true,
                  selectionOverlay: const SizedBox.shrink(),
                  childCount: _months.length,
                  onSelectedItemChanged: (index) {
                    GearSoundService().triggerGearFeedback();
                    setState(() {
                      _selectedMonth = index + 1;
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final monthName = _months[index];
                    final isSelected = (index + 1) == _selectedMonth;
                    return Center(
                      child: Text(
                        monthName,
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: isSelected ? 19 : 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? CommonColors.primaryColor
                              : CommonColors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Separator line
              Container(
                height: 100,
                width: 1,
                color: CommonColors.divider.withAlpha(140),
              ),
              // 3. Year Wheel
              Expanded(
                flex: 3,
                child: CupertinoPicker.builder(
                  scrollController: _yearController,
                  itemExtent: 44,
                  diameterRatio: 1.25,
                  squeeze: 1.18,
                  magnification: 1.12,
                  useMagnifier: true,
                  selectionOverlay: const SizedBox.shrink(),
                  childCount: _years.length,
                  onSelectedItemChanged: (index) {
                    GearSoundService().triggerGearFeedback();
                    setState(() {
                      _selectedYear = _years[index];
                    });
                    _notifyDateChanged();
                  },
                  itemBuilder: (context, index) {
                    final year = _years[index];
                    final isSelected = year == _selectedYear;
                    return Center(
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: isSelected ? 20 : 17,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? CommonColors.primaryColor
                              : CommonColors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
