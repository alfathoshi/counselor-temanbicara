import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultDate extends StatelessWidget {
  final List<DateTime> eventDates;

  const ConsultDate({
    super.key,
    required this.eventDates,
  });

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLinePicker.itemBuilder(
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 6)),
      focusedDate: DateTime.now(),
      itemExtent: 64.0,
      headerOptions: const HeaderOptions(headerType: HeaderType.none),
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        bool hasEvent = eventDates.any((d) =>
            d.year == date.year && d.month == date.month && d.day == date.day);

        return Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: hasEvent ? primaryColor.withValues(alpha: 0.1) : whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.MMM().format(date),
                  style: h5SemiBold.copyWith(
                    color: black,
                  ),
                ),
                Text(
                  date.day.toString(),
                  style: h3Bold.copyWith(
                    color: black,
                  ),
                ),
                Text(
                  DateFormat.E().format(date),
                  style: h6Regular.copyWith(
                    color: greyColor,
                  ),
                ),
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
      onDateChange: (_) {},
    );
  }
}
