import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ApartmentBookingCalendar extends StatelessWidget {
  final controller;

  const ApartmentBookingCalendar({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedRange = controller.selectedRange.value;

      return TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(2030),
        focusedDay: controller.focusedDay.value,

        rangeSelectionMode: RangeSelectionMode.toggledOn,
        rangeStartDay: selectedRange?.start,
        rangeEndDay: selectedRange?.end,

        enabledDayPredicate: (day) => !controller.isDisabled(day),

        calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black),
          rangeStartDecoration: BoxDecoration(
            color: Color(0xFF894EFF),
            shape: BoxShape.circle,
          ),
          rangeEndDecoration: BoxDecoration(
            color: Color(0xFF894EFF),
            shape: BoxShape.circle,
          ),
          rangeHighlightColor: Color(0xE4A287D9),
          disabledTextStyle: TextStyle(
              color: Get.isDarkMode ? Color(0xFD676767) : Color(0xFDA1A1A1),
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red
          ),
          // isTodayHighlighted: false,
          rangeStartTextStyle: TextStyle(color: Colors.white),
          rangeEndTextStyle: TextStyle(color: Colors.white),
        ),

        onDaySelected: (selectedDay, focusedDay) {
          if (controller.isDisabled(selectedDay)) return;

          final currentRange = controller.selectedRange.value;

          if (currentRange == null) {
            controller.selectedRange.value =
                DateTimeRange(start: selectedDay, end: selectedDay);
          }
          else if (currentRange.start != null &&
              currentRange.end == currentRange.start) {
            if (selectedDay.isBefore(currentRange.start)) {
              controller.selectedRange.value =
                  DateTimeRange(start: selectedDay, end: currentRange.start);
            } else {
              controller.selectedRange.value =
                  DateTimeRange(start: currentRange.start, end: selectedDay);
            }
          }
          else if (currentRange.start != null && currentRange.end != null) {
            controller.selectedRange.value =
                DateTimeRange(start: selectedDay, end: selectedDay);
          }
          controller.focusedDay.value = selectedDay;
        },
      );
    });
  }
}
