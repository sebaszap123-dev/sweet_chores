import 'package:sweet_chores/src/models/models.dart';

enum TimeDates { today, tomorrow, yesterday, none }

bool isOverDue(Todo todo) {
  return todo.dueDate != null &&
      todo.dueDate! < DateTime.now().millisecondsSinceEpoch &&
      !todo.isDone;
}

String dateFormatted(DateTime date, TimeDates timeDates,
    {bool hasTime = false}) {
  if (TimeDates.none == timeDates) {
    return '${_getWeekDay(date.weekday)}, ${date.day} ${_getMonth(date.month)}${hasTime ? ', ${timeFormatted(date)}' : ''}';
  } else {
    return '${timeDates.name}${hasTime ? ', ${timeFormatted(date)}' : ''}';
  }
}

String? parseDueDate(int? dueDate, {bool hasTime = false}) {
  DateTime? date =
      dueDate != null ? DateTime.fromMillisecondsSinceEpoch(dueDate) : null;

  if (date == null) {
    return null;
  }

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
      return 'Monday';
    case DateTime.tuesday:
      return 'Tuesday';
    case DateTime.wednesday:
      return 'Wednesday';
    case DateTime.thursday:
      return 'Thursday';
    case DateTime.friday:
      return 'Friday';
    case DateTime.saturday:
      return 'Saturday';
    case DateTime.sunday:
      return 'Sunday';
    default:
      return 'Unknown';
  }
}

String _getMonth(int month) {
  switch (month) {
    case DateTime.january:
      return "January";
    case DateTime.february:
      return "February";
    case DateTime.march:
      return "March";
    case DateTime.april:
      return "April";
    case DateTime.may:
      return "May";
    case DateTime.june:
      return "June";
    case DateTime.july:
      return "July";
    case DateTime.august:
      return "August";
    case DateTime.september:
      return "September";
    case DateTime.october:
      return "October";
    case DateTime.november:
      return "November";
    case DateTime.december:
      return "December";
    default:
      return "Unknown";
  }
}
