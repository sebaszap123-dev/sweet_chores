import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';

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

PrimaryColors get appTheme => PrimaryColors();
ThemeData get theme => SweetThemes.sweetboy();
