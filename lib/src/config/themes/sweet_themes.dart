import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/themes/theme_colors.dart';

enum SweetChoresThemes { sweetboy, sweetgirl }

mixin SweetThemes implements ThemeData {
  static ThemeData sweetboy({bool darkMode = false}) {
    return ThemeData(
      // textTheme: GoogleFonts.spicyRiceTextTheme(),
      colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: darkMode
            ? SweetBoyThemeColors().primaryDark
            : SweetBoyThemeColors.primary,
        onPrimary: Colors.black,
        secondary: darkMode
            ? SweetBoyThemeColors().secondaryDark
            : SweetBoyThemeColors.secondary,
        onSecondary: Colors.white,
        tertiary: darkMode
            ? SweetBoyThemeColors().tertiaryDark
            : SweetBoyThemeColors.tertiary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkMode
            ? SweetBoyThemeColors().primaryDark
            : SweetBoyThemeColors.primary,
        elevation: 0,
      ),
      scaffoldBackgroundColor: Colors.white,
      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return darkMode
                ? SweetBoyThemeColors().blueGrayDark
                : SweetBoyThemeColors.blueGray;
          }
          return Colors.white;
        }),
      ),
      iconTheme: IconThemeData(
        color: darkMode
            ? SweetBoyThemeColors().secondaryDark
            : SweetBoyThemeColors.secondary,
      ),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return darkMode
                ? SweetBoyThemeColors().secondaryDark
                : SweetBoyThemeColors.secondary;
          }
          return Colors.white;
        }),
      )),
      listTileTheme: ListTileThemeData(
        iconColor: darkMode
            ? SweetBoyThemeColors().secondaryDark
            : SweetBoyThemeColors.secondary,
        enableFeedback: true,
      ),
      dividerColor: SweetBoyThemeColors.tertiary,
    );
  }

  static ThemeData sweetgirl({bool darkMode = false}) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: darkMode
            ? SweetGirlThemeColors().primaryDark
            : SweetGirlThemeColors.primary,
        onPrimary: Colors.black,
        secondary: darkMode
            ? SweetGirlThemeColors().secondaryDark
            : SweetGirlThemeColors.secondary,
        onSecondary: Colors.white,
        tertiary: SweetGirlThemeColors.tertiary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkMode
            ? SweetGirlThemeColors().primaryDark
            : SweetGirlThemeColors.primary,
      ),
      scaffoldBackgroundColor: Colors.white,
      checkboxTheme: CheckboxThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return darkMode
                ? SweetGirlThemeColors().pinkGrayDark
                : SweetGirlThemeColors.pinkGray;
          }
          return Colors.white;
        }),
      ),
      iconTheme: IconThemeData(
        color: darkMode
            ? SweetGirlThemeColors().secondaryDark
            : SweetGirlThemeColors.secondary,
      ),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return darkMode
                ? SweetGirlThemeColors().secondaryDark
                : SweetGirlThemeColors.secondary;
          }
          return Colors.white;
        }),
      )),
      listTileTheme: ListTileThemeData(
        iconColor: darkMode
            ? SweetGirlThemeColors().secondaryDark
            : SweetGirlThemeColors.secondary,
      ),
      dividerColor: SweetGirlThemeColors.tertiary,
    );
  }

  static ThemeData themeByType(SweetChoresThemes theme,
      {bool darkMode = false}) {
    if (theme == SweetChoresThemes.sweetboy) {
      return sweetboy(darkMode: darkMode);
    } else {
      return sweetgirl(darkMode: darkMode);
    }
  }
}
