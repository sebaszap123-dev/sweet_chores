import 'dart:convert';

class Todo {
  int? id;
  final String title;
  bool isDone;
  final int categoryID;
  final String? description;
  final int? dueDate;
  bool hasTime;
  Todo({
    this.id,
    required this.title,
    this.isDone = false,
    this.hasTime = false,
    this.categoryID = 1,
    this.description,
    this.dueDate,
  });

  Todo copyWith({
    int? id,
    String? title,
    bool? isDone,
    int? categoryID,
    String? description,
    int? dueDate,
    bool? hasTime,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        categoryID: categoryID ?? this.categoryID,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        hasTime: hasTime ?? this.hasTime,
      );

  factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Todo.fromJson(Map<String, dynamic> json) {
    final rawDone = json["isDone"] as int;
    final rawTime = json["hasTime"] as int;
    return Todo(
      id: json['id'],
      title: json["title"],
      isDone: rawDone == 1 ? true : false,
      categoryID: json['category_id'],
      description: json["description"],
      dueDate: json['dueDate'],
      hasTime: rawTime == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "isDone": isDone ? 1 : 0,
        "dueDate": dueDate,
        "category_id": categoryID,
        "hasTime": hasTime ? 1 : 0,
      };
}

extension DateTimeExtension on DateTime {
  // Obtener el final de la semana
  DateTime endOfWeek() {
    final daysUntilEndOfWeek = 7 - weekday;
    return add(Duration(days: daysUntilEndOfWeek));
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension DateExtensions on int {
  // Convertir un entero a un objeto DateTime
  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}

extension TodoExtensions on Todo {
  // Verificar si la fecha de vencimiento es antes que otra fecha
  bool isDueBefore(DateTime other) {
    if (dueDate == null) {
      return false; // Si no hay fecha de vencimiento, no es antes que otra fecha
    }
    return dueDate!.toDate().isBefore(other);
  }

  // Verificar si la fecha de vencimiento está dentro de la semana actual
  bool isDueThisWeek() {
    if (dueDate == null) {
      return false; // Si no hay fecha de vencimiento, no está dentro de la semana
    }
    final endOfWeek = DateTime.now().endOfWeek();
    return dueDate!.toDate().isBefore(endOfWeek);
  }
}
