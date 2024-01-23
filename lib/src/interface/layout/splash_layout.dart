import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/core/utils/image_constant.dart';
import 'package:sweet_chores_reloaded/src/core/utils/size_utils.dart';
import 'package:sweet_chores_reloaded/src/localization/app_localization.dart';
import 'package:sweet_chores_reloaded/src/theme/theme_helper.dart';
import 'package:sweet_chores_reloaded/src/widgets/custom_image_view.dart';

@RoutePage()
class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 12.v),
                      SizedBox(
                          width: 162.h,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "lbl_sweet_chores".tr,
                                  style: GoogleFonts.spicyRice(
                                    color: appTheme.blue100,
                                    fontSize: 50,
                                  ),
                                )
                              ]),
                              textAlign: TextAlign.center)),
                      Opacity(
                          opacity: 0.7,
                          child: CustomImageView(
                              imagePath: ImageConstant.imgImg1125photoroom,
                              height: 250.v,
                              width: 251.h)),
                    ]))));
  }
}
