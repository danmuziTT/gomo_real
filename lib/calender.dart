import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // 달력에서 선택한 날짜
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // 일정 데이터
  Map<DateTime, List<String>> _events = {
    DateTime(2024, 11, 18): ['미팅', '프로젝트 진행'],
  };

  // 선택한 날짜에 일정 추가
  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("일정 관리"),
      ),
      body: Column(
        children: [
          // 달력
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),

          // 선택한 날짜에 대한 일정 표시
          ..._getEventsForDay(_selectedDay).map(
                (event) => ListTile(
              title: Text(event),
            ),
          ),

          // 일정 추가 버튼
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_events[_selectedDay] == null) {
                  _events[_selectedDay] = [];
                }
                _events[_selectedDay]?.add('새로운 일정');
              });
            },
            child: Text("일정 추가"),
          ),
        ],
      ),
    );
  }
}

