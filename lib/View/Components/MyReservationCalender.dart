import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_project/Controller/MyReservationsController.dart';
import 'package:uni_project/Model/Reservation_model.dart';

class MyReservationCalender extends StatelessWidget {
  MyReservations? booking;

  MyReservationCalender(MyReservations booking, {super.key});

  final MyReservationsController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(2030),
        focusedDay: DateTime.now(),
        rangeSelectionMode: RangeSelectionMode.enforced,
        rangeStartDay: c.selectedRange.value?.start,
        rangeEndDay: c.selectedRange.value?.end,

        // enabledDayPredicate: (day) {
        //   return !c.disabledDays.any(
        //     (d) => isSameDay(d, day),
        //   );
        // },
        enabledDayPredicate: (day) {
          return !c.isDisabled(day);
        },

        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (c.disabledDays.any((d) => isSameDay(d, day))) {
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
            c.updateRange(DateTimeRange(start: start, end: end));
          }
        },
      ),
    );
  }
}
