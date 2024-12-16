class Diary {
  final int? id;
  final String date; // 날짜 (YYYY-MM-DD)
  final String emotion;
  final String content;

  Diary(
      {this.id,
      required this.date,
      required this.emotion,
      required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'emotion': emotion,
      'content': content,
    };
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'],
      date: map['date'],
      emotion: map['emotion'],
      content: map['content'],
    );
  }
}
