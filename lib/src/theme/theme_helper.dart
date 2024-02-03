import 'package:flutter/material.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';

class PrimaryColors {
  // Amber
  Color get amber500 => const Color(0XFFFFC107);

  // Black
  Color get black900 => const Color(0XFF000000);

  // Blue
  Color get blue100 => const Color(0XFFBBDDFF);

  // BlueGray
  Color get blueGray400 => const Color(0XFF888888);
}

PrimaryColors get appAutoGeneraterTheme => PrimaryColors();
ThemeData get theme => getIt<SweetPreferencesBloc>().state.themeData;
