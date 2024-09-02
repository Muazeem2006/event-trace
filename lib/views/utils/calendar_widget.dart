// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:event_trace/models/Event.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({ Key? key }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}


class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  final Map<DateTime, List<Event>> _events = {};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          color: Theme.of(context).colorScheme.background,
          shadowColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 1, 1),
            focusedDay: today,
            lastDay: DateTime.utc(2030, 12, 31),
            locale: 'en_US',
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              titleCentered: true,
            ),
            availableGestures: AvailableGestures.all,
            onDaySelected: _onDaySelected,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(day, today),
          ),
        ),
        const SizedBox(height: 20),
        Text('Selected date is ${today.day}/${today.month}/${today.year}'),
      ],
    );
  }
}
