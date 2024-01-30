import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/themes/theme_colors.dart';
import 'package:sweet_chores_reloaded/src/core/utils/color_tohex.dart';

Color backgroundColorFromTextColor(Color color) {
  if (color.value == Colors.white.value) {
    return '#121212'.toColor();
  } else {
    return Colors.white;
  }
}

ColorScheme colorSchemeFromThemeColors(SweetThemeColors themeColors) {
  // IF WHITE IS DARK MODE
  if (themeColors.text.value == Colors.white.value) {
    return ColorScheme.dark(
      primary: themeColors.primary,
      secondary: themeColors.secondary,
      tertiary: themeColors.tertiary,
    );
  } else {
    return ColorScheme.light(
      primary: themeColors.primary,
      secondary: themeColors.secondary,
      tertiary: themeColors.tertiary,
    );
  }
}

mixin SweetThemes implements ThemeData {
  static ThemeData sweetThemeData({required SweetThemeColors themeColors}) {
    final textTheme =
        GoogleFonts.robotoTextTheme().apply(bodyColor: themeColors.text);
    return ThemeData(
      textTheme: textTheme,
      colorScheme: colorSchemeFromThemeColors(themeColors),
      appBarTheme: AppBarTheme(
        backgroundColor: themeColors.primary,
        foregroundColor: themeColors.primary,
        shadowColor: themeColors.primary,
        surfaceTintColor: themeColors.primary,
      ),
      drawerTheme: DrawerThemeData(
          backgroundColor: backgroundColorFromTextColor(themeColors.text)),
      cardTheme: CardTheme(
        color: themeColors.primary,
      ),
      scaffoldBackgroundColor: backgroundColorFromTextColor(themeColors.text),
      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return themeColors.grayly;
          }
          return Colors.white;
        }),
      ),
      iconTheme: IconThemeData(
        color: themeColors.primary,
      ),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return themeColors.primary;
          }
          return Colors.white;
        }),
      )),
      listTileTheme: ListTileThemeData(
        iconColor: themeColors.primary,
        enableFeedback: true,
      ),
      dividerColor: themeColors.tertiary,
    );
  }
}
