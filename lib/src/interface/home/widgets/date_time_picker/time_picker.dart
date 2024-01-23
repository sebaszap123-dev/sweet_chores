part of 'sweet_due_date_picker.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key, required this.onTimeSelected});

  final void Function(DateTime) onTimeSelected;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  Time selectedTime = Time(hour: 0, minutes: 0); // Usar tu clase Time
  Timer? _debounce;

  void _handleTimeSelection() {
    _debounce = Timer(const Duration(milliseconds: 800), () {
      final selectedDateTime = createDateTimeFromTime();
      widget.onTimeSelected(
          selectedDateTime); // Llama a la función y pasa el DateTime
    });
  }

  _timeSelected() {
    context.read<TodoBloc>().add(const SaveRawDate(true));
  }

  DateTime createDateTimeFromTime() {
    final now = DateTime.now();

    final selectedHour = selectedTime.hour;
    _timeSelected();
    if (selectedHour < now.hour ||
        (selectedHour == now.hour && selectedTime.minutes <= now.minute)) {
      // La hora seleccionada es para mañana.
      return DateTime(
          now.year, now.month, now.day + 1, selectedHour, selectedTime.minutes);
    } else {
      // La hora seleccionada es para hoy.
      return DateTime(
          now.year, now.month, now.day, selectedHour, selectedTime.minutes);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.symmetric(vertical: 4);
    return Center(
      child: Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: margin,
              width: 60,
              child: CupertinoPicker(
                backgroundColor: Colors.transparent,
                itemExtent: 40.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedTime = selectedTime.copyWith(hour: index);
                    _handleTimeSelection();
                  });
                },
                children: List<Widget>.generate(24, (int index) {
                  return Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  );
                }),
              ),
            ),
            Container(
              width: 60,
              margin: margin,
              child: CupertinoPicker(
                backgroundColor: Colors.transparent,
                itemExtent: 40.0,
                useMagnifier: true,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedTime = selectedTime.copyWith(minutes: index);
                    _handleTimeSelection();
                  });
                },
                children: List<Widget>.generate(60, (int index) {
                  return Center(
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Time {
  Time({required this.hour, required this.minutes});
  final int hour;
  final int minutes;

  Time copyWith({
    int? hour,
    int? minutes,
  }) {
    return Time(
      hour: hour ?? this.hour,
      minutes: minutes ?? this.minutes,
    );
  }
}
