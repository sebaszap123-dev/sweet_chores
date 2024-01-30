import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';
import 'package:sweet_chores_reloaded/src/theme/custom_button_style.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);

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
                                  text: "lbl_hi_weelcome_to".tr,
                                  style: GoogleFonts.spicyRice(
                                    color: appAutoGeneraterTheme.blue100,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: "lbl_sweet_chores".tr,
                                  style: GoogleFonts.spicyRice(
                                    color: appAutoGeneraterTheme.blue100,
                                    fontSize: 50,
                                  ),
                                )
                              ]),
                              textAlign: TextAlign.center)),
                      Opacity(
                          opacity: 0.7,
                          child: CustomImageView(
                              imagePath: ImageConstant.welcomeCinnamon,
                              height: 250.v,
                              width: 251.h)),
                      const SizedBox(height: 80),
                      CustomElevatedButton(
                          height: 55.v,
                          width: 200.h,
                          text: "lbl_get_started".tr,
                          buttonStyle: CustomButtonStyles.fillBlue,
                          buttonTextStyle:
                              CustomTextStyles.headlineSmallBackground,
                          onTap: () {
                            onTapGetstarted(context);
                          })
                    ]))));
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the loginScreen.
  onTapGetstarted(BuildContext context) async {
    AutoRouter.of(context).push(const HomeRoute());
    await SweetChoresPreferences.initializedApp();
  }
}
