import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_project/Controller/BookingController.dart';

class ApartmentBookingCalendar extends StatelessWidget {
  ApartmentBookingCalendar({super.key});

  final BookingController bookingRangesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime(2030),
      focusedDay: DateTime.now(),
      rangeSelectionMode: RangeSelectionMode.enforced,
      rangeStartDay: bookingRangesController.selectedRange.value?.start,
      rangeEndDay: bookingRangesController.selectedRange.value?.end,

      // enabledDayPredicate: (day) {
      //   return !bookingRangesController.disabledDays.any(
      //     (d) => isSameDay(d, day),
      //   );
      // },
      enabledDayPredicate: (day) {
        return !bookingRangesController.isDisabled(day);
      },

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          if (bookingRangesController.disabledDays.any(
            (d) => isSameDay(d, day),
          )) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return null;
        },
      ),

      onRangeSelected: (start, end, focusedDay) {
        if (start != null && end != null) {
          bookingRangesController.updateRange(
            DateTimeRange(start: start, end: end),
          );
        }
      },
    );
  }
}
