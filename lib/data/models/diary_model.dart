class Diary {
  final String date;
  final String emotion;
  final String content;

  Diary({required this.date, required this.emotion, required this.content});

  // Map으로 변환
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'emotion': emotion,
      'content': content,
    };
  }

  // Map에서 Diary 객체로 변환
  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      date: map['date'],
      emotion: map['emotion'],
      content: map['content'],
    );
  }
}
