import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/core/utils/color_tohex.dart';

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

class SweetBoyThemeColors {
  SweetBoyThemeColors();
  static Color primary = '#b4cfe9'.toColor();
  static Color primary2 = '#CEE7FF'.toColor();
  static Color secondary = '#9FC9F3'.toColor();
  static Color tertiary = '#cee6ff'.toColor();
  static Color lowBlueCard = '#e0f0ff'.toColor();
  static Color lightBlue = '#9fc9f3'.toColor();
  static Color tinyBlue = '#dbedff'.toColor();
  static Color blueGray = '#648cb4'.toColor();
  static Color secondaryShadow = '#7695b4'.toColor();
  static Color userName = '#648CB4'.toColor();
  static Color overDue = '#FFCECE'.toColor();
}

extension SweetBoyThemeColorsDark on SweetBoyThemeColors {
  Color get primaryDark => '#004ba0'.toColor();
  Color get primary2Dark => '#002f6c'.toColor();
  Color get secondaryDark => '#003d80'.toColor();
  Color get checkedColorDark => Colors.indigoAccent;
  Color get tertiaryDark => '#002f6c'.toColor();
  Color get lowBlueCardDark => '#000a33'.toColor();
  Color get lightBlueDark => '#003d80'.toColor();
  Color get tinyBlueDark => '#002f6c'.toColor();
  Color get blueGrayDark => '#001a40'.toColor();
  Color get secondaryShadowDark => '#002f6c'.toColor();
  Color get userNameDark => '#000a33'.toColor();
  Color get overDueDark => '#330000'.toColor();
}

class SweetGirlThemeColors {
  static Color primary = '#FFB6C1'.toColor(); // Rosa claro
  static Color primary2 = '#FFD9E6'.toColor(); // Rosa muy claro
  static Color secondary = '#FF69B4'.toColor(); // Rosa intenso
  static Color tertiary = '#FFC0CB'.toColor(); // Rosa claro más fuerte
  static Color lowPinkCard = '#FFEBF2'.toColor(); // Rosa claro suave
  static Color lightPink = '#FFC0CB'.toColor(); // Rosa claro más fuerte
  static Color tinyPink = '#FFD9E6'.toColor(); // Rosa muy claro más fuerte
  static Color pinkGray = '#C71585'.toColor(); // Rosa oscuro
  static Color secondaryShadow =
      '#FF69B4'.toColor(); // Rosa intenso (usando el mismo que secondary)
  static Color userName =
      '#C71585'.toColor(); // Rosa oscuro (usando el mismo que pinkGray)
  static Color overDue = '#FFC0CB'
      .toColor(); // Rosa claro más fuerte (usando el mismo que tertiary)
}

extension SweetGirlThemeColorsDark on SweetGirlThemeColors {
  Color get primaryDark => '#880E4F'.toColor();
  Color get primary2Dark => '#B0003A'.toColor();
  Color get secondaryDark => '#C2185B'.toColor();
  Color get tertiaryDark => '#E91E63'.toColor();
  Color get lowPinkCardDark => '#4A148C'.toColor();
  Color get lightPinkDark => '#C2185B'.toColor();
  Color get tinyPinkDark => '#B0003A'.toColor();
  Color get pinkGrayDark => '#880E4F'.toColor();
  Color get secondaryShadowDark => '#C2185B'.toColor();
  Color get userNameDark => '#4A148C'.toColor();
  Color get overDueDark => '#E91E63'.toColor();
}
