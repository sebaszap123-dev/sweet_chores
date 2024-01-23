import 'package:flutter/material.dart';

Future<DateTime?> callDueDatePicker(BuildContext context) async {
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now());
  return dateTime;
}
