import 'package:FlutterScaffold/common/controlls/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TestCalendar extends StatefulWidget {
  const TestCalendar({Key? key}) : super(key: key);

  @override
  _TestCalendarState createState() => _TestCalendarState();
}

class _TestCalendarState extends State<TestCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("Test Calendar"),
        body: TableCalendar(
          firstDay: DateTime.utc(2021, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          // shouldFillViewport: true,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          // onFormatChanged: (format) {
          //   if (_calendarFormat != format) {
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   }
          // },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                  color: Colors.amber,
                  child: Center(child: Text("${day.day}")));
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                  color: Colors.red, child: Center(child: Text("${day.day}")));
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                  color: Colors.blue, child: Center(child: Text("${day.day}")));
            },
            outsideBuilder: (context, day, focusedDay) {
              return Container(
                  color: Colors.green,
                  child: Center(child: Text("${day.day}")));
            },
            disabledBuilder: (context, day, focusedDay) {
              return Container(
                  color: Colors.yellow,
                  child: Center(child: Text("${day.day}")));
            },
            dowBuilder: (context, day) {
              final weekdayString = DateFormat.E().format(day);
              // final isWeekend =
              //     _isWeekend(day, weekendDays: widget.weekendDays);
              var dowCell = Center(
                child: ExcludeSemantics(
                  child: Text(
                    weekdayString,
                    // style: isWeekend
                    //     ? widget.daysOfWeekStyle.weekendStyle
                    //     : widget.daysOfWeekStyle.weekdayStyle,
                  ),
                ),
              );
              return dowCell;
            },
          ),
        ));
  }
}
