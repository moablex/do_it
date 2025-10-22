import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskHistory extends StatefulWidget {
  const TaskHistory({super.key});

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime(2025, 10, 8);
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Selector')),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2025, 10, 5), // Start of week (Sunday)
          lastDay: DateTime.utc(2025, 10, 11), // End of week (Saturday)
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            todayDecoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
            weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
            outsideDecoration: const BoxDecoration(shape: BoxShape.circle),
            holidayDecoration: const BoxDecoration(shape: BoxShape.circle),
          ),
          headerVisible: true,
          daysOfWeekVisible: true,
          rowHeight: 50,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(fontSize: 12),
            weekendStyle: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
