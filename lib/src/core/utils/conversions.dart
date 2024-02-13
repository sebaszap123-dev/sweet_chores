import 'package:sweet_chores/src/models/models.dart';

enum TimeDates { today, tomorrow, yesterday, none }

bool isOverDue(Todo todo) {
  return todo.dueDate != null &&
      todo.dueDate! < DateTime.now().millisecondsSinceEpoch &&
      !todo.isDone;
}

String dateFormatted(DateTime date, TimeDates timeDates,
    {bool hasTime = false}) {
  final now = DateTime.now();
  if (TimeDates.none == timeDates) {
    return '${_getWeekDay(date.weekday)}, ${date.day} ${_getMonth(date.month)}, ${now.year == date.year ? '' : '${date.year}'}${hasTime ? ', ${timeFormatted(date)}' : ''}';
  } else {
    return '${timeDates.name}${hasTime ? ', ${timeFormatted(date)}' : ''}';
  }
}

String parseDueDate(int dueDate, {bool hasTime = false}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dueDate);

  DateTime now = DateTime.now();
  DateTime today = DateTime(
    now.year,
    now.month,
    now.day,
    date.hour,
    date.minute,
    date.second,
  );
  DateTime tomorrow = today.add(const Duration(days: 1));
  DateTime yesterday = today.subtract(const Duration(days: 1));

  if (date.isAtSameMomentAs(today)) {
    return dateFormatted(date, TimeDates.today, hasTime: hasTime);
  } else if (date.isAtSameMomentAs(tomorrow)) {
    return dateFormatted(date, TimeDates.tomorrow, hasTime: hasTime);
  } else if (date.isAtSameMomentAs(yesterday)) {
    return dateFormatted(date, TimeDates.yesterday, hasTime: hasTime);
  } else {
    return dateFormatted(date, TimeDates.none, hasTime: hasTime);
  }
}

String timeFormatted(DateTime time) {
  final hour = time.hour;
  final minute = time.minute;

  String hourStr = hour.toString().padLeft(2, '0');
  String minuteStr = minute.toString().padLeft(2, '0');

  return "$hourStr:$minuteStr";
}

String _getWeekDay(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thur';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return 'Unknown';
  }
}

String _getMonth(int month) {
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  if (month >= DateTime.january && month <= DateTime.december) {
    return months[month - 1]; // Resta 1 para ajustar el índice de la lista
  } else {
    return "Unknown";
  }
}
