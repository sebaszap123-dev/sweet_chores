import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/core/utils/color_tohex.dart';

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
  final Color alternative;
  final Color primary2;
  final Color secondary;
  final Color tertiary;
  final Color lowCard;
  final Color light;
  final Color tiny;
  final Color grayly;
  final Color secondaryShadow;
  final Color overDue;

  SweetThemeColors({
    required this.primary,
    required this.alternative,
    required this.primary2,
    required this.secondary,
    required this.tertiary,
    required this.lowCard,
    required this.light,
    required this.tiny,
    required this.grayly,
    required this.secondaryShadow,
    required this.overDue,
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
    primary: '#b4cfe9'.toColor(),
    alternative: '#bbddff'.toColor(),
    primary2: '#CEE7FF'.toColor(),
    secondary: '#9FC9F3'.toColor(),
    tertiary: '#cee6ff'.toColor(),
    lowCard: '#e0f0ff'.toColor(),
    light: '#9fc9f3'.toColor(),
    tiny: '#dbedff'.toColor(),
    grayly: '#648cb4'.toColor(),
    secondaryShadow: '#7695b4'.toColor(),
    overDue: '#FFCECE'.toColor(),
  );

  static final SweetThemeColors _darkCinnamonTheme = SweetThemeColors(
    primary: '#004ba0'.toColor(),
    alternative: '#001a40'.toColor(),
    primary2: '#002f6c'.toColor(),
    secondary: '#003d80'.toColor(),
    tertiary: '#002f6c'.toColor(),
    lowCard: '#000a33'.toColor(),
    light: '#003d80'.toColor(),
    tiny: '#002f6c'.toColor(),
    grayly: '#001a40'.toColor(),
    secondaryShadow: '#002f6c'.toColor(),
    overDue: '#330000'.toColor(),
  );

  static final SweetThemeColors _lightStrawBerryTheme = SweetThemeColors(
    primary: '#FBCEC3'.toColor(),
    primary2: '#FFE4ED'.toColor(),
    secondary: '#FF8CBA'.toColor(),
    tertiary: '#FFE4ED'.toColor(),
    secondaryShadow: '#FF8CBA'.toColor(),
    overDue: '#FFE4ED'.toColor(),
    alternative: '#ffccd2'.toColor(),
    lowCard: '#FFF4F7'.toColor(),
    light: '#FF8CBA'.toColor().withOpacity(0.8),
    tiny: '#FFE4ED'.toColor(),
    grayly: '#C71585'.toColor(),
  );

  static final SweetThemeColors _darkStrawBerryTheme = SweetThemeColors(
    primary: '#880E4F'.toColor(),
    primary2: '#B0003A'.toColor(),
    secondary: '#C2185B'.toColor(),
    tertiary: '#E91E63'.toColor(),
    secondaryShadow: '#C2185B'.toColor(),
    overDue: '#E91E63'.toColor(),
    alternative: '#a17987'.toColor(),
    lowCard: '#4A148C'.toColor(),
    light: '#C2185B'.toColor(),
    tiny: '#B0003A'.toColor(),
    grayly: '#880E4F'.toColor(),
  );
}
