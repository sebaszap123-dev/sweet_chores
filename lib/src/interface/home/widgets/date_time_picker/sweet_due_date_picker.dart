import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/core/utils/helpers.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';

part 'card_date_time_picker.dart';
part 'calendar_picker.dart';
part 'time_picker.dart';

enum Picker { date, time }

class SweetDueDatePicker extends StatefulWidget {
  const SweetDueDatePicker({super.key, required this.onChangeDate});
  final void Function(DateTime?) onChangeDate;
  @override
  State<SweetDueDatePicker> createState() => _SweetDueDatePickerState();
}

class _SweetDueDatePickerState extends State<SweetDueDatePicker> {
  DateTime? selectedDate;
  DateTime? selectedTime;

  void _handleDate() {
    if (selectedDate != null && selectedTime != null) {
      DateTime updatedDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute);
      widget.onChangeDate(updatedDateTime);
    } else if (selectedDate != null && selectedTime == null) {
      DateTime date = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        23,
        59,
        59,
      );
      widget.onChangeDate(date);
    } else if (selectedTime != null && selectedDate == null) {
      DateTime updatedDateTime = DateTime(
        selectedTime!.year,
        selectedTime!.month,
        selectedTime!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      widget.onChangeDate(updatedDateTime);
    } else {
      widget.onChangeDate(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            _CardDateTimePicker(
              title: 'Date',
              type: Picker.date,
              onChangeDateOrTime: (date) {
                setState(() {
                  selectedDate = date;
                  _handleDate();
                });
              },
            ),
            const SizedBox(height: 10),
            _CardDateTimePicker(
              title: 'Time',
              type: Picker.time,
              onChangeDateOrTime: (time) {
                setState(() {
                  selectedTime = time;
                  _handleDate();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
