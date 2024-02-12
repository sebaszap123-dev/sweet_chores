import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/core/app_export.dart';

@RoutePage()
class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = SweetThemeColors.fromDefault().primary;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Come back soon!',
            style: GoogleFonts.spicyRice().copyWith(
              color: primary,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Bye Bye!',
            style: GoogleFonts.spicyRice().copyWith(
              color: primary,
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            ImageConstant.deleteAccountGoodBye,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
