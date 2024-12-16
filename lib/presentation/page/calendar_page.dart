import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:emotionpot/data/models/diary_model.dart';
import 'package:emotionpot/data/providers/diary_provider.dart';

import 'write_page.dart';

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
        title: const Text(
          '감정 일기 달력',
          style: TextStyle(fontFamily: 'NanumPen', fontSize: 24),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarStyle: CalendarStyle(
              markerDecoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              todayDecoration: const BoxDecoration(
                  color: Colors.lightGreen, shape: BoxShape.circle),
            ),
            eventLoader: (day) {
              return diaries.containsKey(day.toIso8601String().split('T')[0])
                  ? [1]
                  : [];
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              final dateKey = selectedDay.toIso8601String().split('T')[0];
              if (diaries.containsKey(dateKey)) {
                _showDiaryDialog(context, diaries[dateKey]!);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WritePage(selectedEmotion: "기록 없음", date: dateKey),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDiaryDialog(BuildContext context, Diary diary) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('감정: ${diary.emotion}'),
        content: Text(diary.content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
