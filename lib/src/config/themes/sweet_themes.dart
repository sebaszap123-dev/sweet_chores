import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/themes/theme_colors.dart';

mixin SweetThemes implements ThemeData {
  static ThemeData sweetThemeData({required SweetThemeColors themeColors}) {
    return ThemeData(
      textTheme: GoogleFonts.robotoTextTheme(),
      colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: themeColors.primary,
        onPrimary: Colors.black,
        secondary: themeColors.secondary,
        onSecondary: Colors.white,
        tertiary: themeColors.tertiary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: themeColors.primary,
        foregroundColor: themeColors.primary,
        shadowColor: themeColors.primary,
        surfaceTintColor: themeColors.primary,
      ),
      cardTheme: CardTheme(
        color: themeColors.primary,
      ),
      scaffoldBackgroundColor: Colors.white,
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
