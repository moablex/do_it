import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineCalendar extends StatefulWidget {
  TimelineCalendar({super.key});

  @override
  State<TimelineCalendar> createState() => _TimelineCalendarState();
}

class _TimelineCalendarState extends State<TimelineCalendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLinePicker.itemBuilder(
      itemExtent: 64.0,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2030, 3, 18),
      focusedDate: _selectedDate,
      itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        final dayNameShort = DateFormat('E').format(date);
        return InkResponse(
          onTap: onTap,
          child: Card(
            color: isSelected ? Colors.blue : null,
            //  backgroundColor: isSelected ? Colors.blue : null,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(dayNameShort, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        );
      },
      onDateChange: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }
}
