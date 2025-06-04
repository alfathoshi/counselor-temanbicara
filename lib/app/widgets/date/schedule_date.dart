import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDate extends StatelessWidget {
  final List<DateTime> eventDates;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime focusedDate;

  const ScheduleDate({
    super.key,
    required this.eventDates,
    required this.onDateSelected,
    required this.focusedDate,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentMonth = DateTime.now();
    return EasyDateTimeLinePicker.itemBuilder(
      firstDate: _getFirstDayOfMonth(currentMonth),
      lastDate: _getLastDayOfMonth(currentMonth),
      focusedDate: focusedDate,
      itemExtent: 64.0,
      onDateChange: onDateSelected,
      monthYearPickerOptions: MonthYearPickerOptions(
        confirmTextStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        cancelTextStyle: const TextStyle(
          color: Colors.grey,
        ),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: child ?? const SizedBox(),
          );
        },
      ),
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        bool hasEvent = eventDates.any((d) =>
            d.year == date.year && d.month == date.month && d.day == date.day);

        return GestureDetector(
          onTap: () {
            onTap();
            onDateSelected(date);
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  isSelected ? primaryColor.withValues(alpha: 0.2) : whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat.MMM().format(date),
                    style: h5SemiBold.copyWith(
                        color: isSelected ? primaryColor : grey3Color)),
                Text(date.day.toString(),
                    style: h3Bold.copyWith(
                        color: isSelected ? primaryColor : black)),
                Text(DateFormat.E().format(date),
                    style: h6Regular.copyWith(
                        color: isSelected ? primaryColor : greyColor)),
                const SizedBox(height: 4),
                hasEvent
                    ? Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : const SizedBox(height: 6),
              ],
            ),
          ),
        );
      },
    );
  }
}

DateTime _getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

// Function buat ngitung tanggal akhir bulan
DateTime _getLastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0).add(const Duration(days: 365));
}
