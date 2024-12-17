// calendar_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/providers/diary_provider.dart';
import 'diary_detail_page.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final diaries = ref.watch(diaryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '달력',
          style: TextStyle(fontFamily: 'NanumPen', fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) {
              final dateKey = _formatDateKey(day);
              return diaries.containsKey(dateKey) ? [1] : [];
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              final dateKey = _formatDateKey(selectedDay);
              if (diaries.containsKey(dateKey)) {
                // 선택한 날짜의 일기를 상세 페이지로 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DiaryDetailPage(diary: diaries[dateKey]!),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String _formatDateKey(DateTime day) {
    return '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
  }
}
