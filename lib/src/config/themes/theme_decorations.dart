import 'package:flutter/material.dart';

class ThemeDecorations {
  static InputDecoration kawaiBorder({
    required BuildContext context,
    String? label,
    String? hintext,
    Color? color,
    bool isDarkMode = false,
  }) =>
      InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: color ?? (isDarkMode ? Colors.white : Colors.black),
        ),
        hintText: hintext,
        fillColor: color,
        counterStyle: TextStyle(color: color),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color ?? (isDarkMode ? Colors.white : Colors.black),
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      );
  static InputDecoration kawaiBorderIcon({
    required BuildContext context,
    String? label,
    String? hintext,
    IconData? icon,
    Color? color,
    Color? iconColor,
  }) =>
      InputDecoration(
          prefixIconConstraints:
              icon == null ? const BoxConstraints(maxWidth: 18) : null,
          prefixIcon: Icon(
            icon,
            color: iconColor,
            size: 30,
            fill: 1,
          ),
          labelText: label,
          hintText: hintext,
          filled: color != null ? true : false,
          fillColor: color,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: color ?? Theme.of(context).colorScheme.secondary,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color ?? Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color ?? Colors.grey,
            ),
          ));
}
