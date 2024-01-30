import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMedium13 => theme.textTheme.bodyMedium!.copyWith(
      color: appAutoGeneraterTheme.blue100,
      fontSize: 13.fSize,
      fontWeight: FontWeight.bold);
  static get bodyMedium13_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appAutoGeneraterTheme.blue100,
        fontSize: 13.fSize,
      );
  // Headline text style
  static get headlineSmallBackground => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.background,
      );
  static get headlineSmallBlue100 => theme.textTheme.headlineSmall!.copyWith(
        color: appAutoGeneraterTheme.blue100,
      );
  static get headlineSmallBlue100_1 => theme.textTheme.headlineSmall!.copyWith(
        color: appAutoGeneraterTheme.blue100,
      );
  static get headlineSmallOnPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  // Label text style
  static get labelLargeSFProText =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appAutoGeneraterTheme.blue100,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }
}
