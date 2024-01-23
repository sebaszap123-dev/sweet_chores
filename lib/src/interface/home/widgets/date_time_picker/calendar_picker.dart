part of 'sweet_due_date_picker.dart';

class CalendarPicker extends StatelessWidget {
  const CalendarPicker({super.key, required this.onDateChanged});
  final void Function(DateTime) onDateChanged;
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: _calculateLastDate(),
      onDateChanged: onDateChanged,
    );
  }

  DateTime _calculateLastDate() {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 200, 12, 31);
    return lastDate;
  }
}
