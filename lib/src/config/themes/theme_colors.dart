import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/utils/color_tohex.dart';

enum SweetMode { light, dark }

enum SweetTheme { cinnamon, strawberry }

final List<Color> sweetIconColors = [
  '#BBC2FF'.toColor(),
  '#c7ff8f'.toColor(),
  '#FFFB8F'.toColor(),
  '#ffd8bb'.toColor(),
  '#ffbbbb'.toColor(),
  '#FD8FFF'.toColor(),
  '#cd8fff'.toColor(),
  '#bbddff'.toColor(),
  '#7bb0ff'.toColor(),
  '#8eff7b'.toColor(),
  '#f9f361'.toColor(),
  '#ffbd80'.toColor(),
  '#ff7b7b'.toColor(),
  '#ff7bca'.toColor(),
  '#9d7bff'.toColor(),
  '#7bd0ff'.toColor(),
  '#988ed3'.toColor(),
  '#8ec2d3'.toColor(),
  '#98d38e'.toColor(),
  '#d3cc8e'.toColor(),
  '#d38e8e'.toColor(),
  '#d3af8e'.toColor(),
  '#dadada'.toColor(),
  '#000000'.toColor(),
];

class SweetThemeColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color grayly;
  final Color overDue;
  final Color text;
  SweetThemeColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.grayly,
    required this.overDue,
    required this.text,
  });

  static SweetThemeColors fromDefault() {
    return SweetThemeColors.fromMode(SweetMode.light, SweetTheme.cinnamon);
  }

  factory SweetThemeColors.fromMode(SweetMode mode, SweetTheme theme) {
    if (mode == SweetMode.dark) {
      return theme == SweetTheme.cinnamon
          ? _darkCinnamonTheme
          : _darkStrawBerryTheme;
    } else {
      return theme == SweetTheme.cinnamon
          ? _lightCinnamonTheme
          : _lightStrawBerryTheme;
    }
  }

  static final SweetThemeColors _lightCinnamonTheme = SweetThemeColors(
    // Primary 60 (blanco) Secondary 30 (#cee6ff) y tertiary 10 (#CFD7FF)
    text: Colors.black,
    primary: '#cee6ff'.toColor(),
    secondary: '#A0CAF4'.toColor(),
    tertiary: '#4F7CAC'.toColor(),
    grayly: '#648cb4'.toColor(),
    overDue: '#FFCECE'.toColor(),
  );

  static final SweetThemeColors _darkCinnamonTheme = SweetThemeColors(
    text: Colors.white,
    primary: '#004ba0'.toColor(),
    secondary: '#003d80'.toColor(),
    tertiary: '#002f6c'.toColor(),
    grayly: '#001a40'.toColor(),
    overDue: '#330000'.toColor(),
  );

  static final SweetThemeColors _lightStrawBerryTheme = SweetThemeColors(
    text: Colors.black,
    primary: '#FBCEC3'.toColor(),
    secondary: '#FF8CBA'.toColor(),
    tertiary: '#FFE4ED'.toColor(),
    overDue: '#FFE4ED'.toColor(),
    grayly: '#C71585'.toColor(),
  );

  static final SweetThemeColors _darkStrawBerryTheme = SweetThemeColors(
    text: Colors.white,
    primary: '#880E4F'.toColor(),
    secondary: '#C2185B'.toColor(),
    tertiary: '#E91E63'.toColor(),
    overDue: '#E91E63'.toColor(),
    grayly: '#880E4F'.toColor(),
  );
}
