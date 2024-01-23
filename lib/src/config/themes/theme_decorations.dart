import 'package:flutter/material.dart';

class ThemeDecorations {
  static InputDecoration kawaiBorder(
          {required BuildContext context,
          String? label,
          String? hintext,
          Color? color}) =>
      InputDecoration(
        labelText: label,
        hintText: hintext,
        contentPadding: const EdgeInsets.all(20),
        filled: color != null ? true : false,
        fillColor: color,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: color ?? Theme.of(context).colorScheme.secondary,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color ?? Colors.grey,
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
