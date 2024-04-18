import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores/src/interface/common/common.dart';

enum ForgotStatus { initial, success, code, loading, error }

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controllerStream = StreamController<ForgotStatus>();

  @override
  void dispose() {
    codeController.dispose();
    controllerStream.close();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: StreamBuilder<ForgotStatus>(
              stream: controllerStream.stream,
              initialData: ForgotStatus.initial,
              builder: (context, snapshot) {
                if (snapshot.data == ForgotStatus.loading) {
                  return const Loading();
                }
                return DefaultTextStyle(
                  style: TextStyle(
                    color: appAutoGeneraterTheme.blue100,
                  ),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            SizedBox(
                                height: 83.v,
                                width: double.maxFinite,
                                child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgEllipse2931x150,
                                          height: 31.v,
                                          width: 150.h,
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: 90.h)),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                              height: 83.v,
                                              width: 112.h,
                                              child: Stack(
                                                  alignment: Alignment.topLeft,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgEllipse3083x112,
                                                        height: 83.v,
                                                        width: 112.h,
                                                        alignment:
                                                            Alignment.center),
                                                    CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgArrowleftOnprimary,
                                                        height: 30.v,
                                                        width: 18.h,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        margin: EdgeInsets.only(
                                                            left: 28.h,
                                                            top: 15.v),
                                                        onTap: () {
                                                          onTapImgArrowleftone(
                                                              context);
                                                        })
                                                  ]))),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgEllipse31,
                                          height: 73.v,
                                          width: 161.h,
                                          alignment: Alignment.topRight)
                                    ])),
                            Padding(
                                padding: EdgeInsets.only(left: 40.h, top: 92.v),
                                child: Text(
                                  "msg_forgot_password2".tr,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                width: 249.h,
                                margin: EdgeInsets.only(left: 40.h),
                                child: Text(
                                  "msg_enter_the_email".tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 43.h, top: 17.v),
                                child: Text(
                                  snapshot.data == ForgotStatus.code
                                      ? "Enter code"
                                      : "msg_email_or_phone_number".tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )),
                            CustomTextFormField(
                                autofocus: false,
                                controller: snapshot.data == ForgotStatus.code
                                    ? codeController
                                    : emailController,
                                margin: EdgeInsets.only(
                                    left: 40.h, top: 10.v, right: 41.h),
                                textInputAction: TextInputAction.done,
                                alignment: Alignment.center),
                            if (snapshot.data == ForgotStatus.code)
                              CustomTextFormField(
                                  autofocus: false,
                                  controller: passwordController,
                                  margin: EdgeInsets.only(
                                      left: 40.h, top: 10.v, right: 41.h),
                                  textInputAction: TextInputAction.done,
                                  alignment: Alignment.center),
                            CustomElevatedButton(
                                text: "lbl_submit".tr,
                                buttonStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        appAutoGeneraterTheme.blue100)),
                                buttonTextStyle:
                                    const TextStyle(color: Colors.white),
                                margin: EdgeInsets.only(
                                    left: 40.h, top: 23.v, right: 41.h),
                                onTap: () {
                                  onTapSubmit(context);
                                },
                                alignment: Alignment.center),
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 48.h, top: 31.v, right: 54.h),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("msg_forgot_email_or".tr,
                                              style: CustomTextStyles
                                                  .bodyMedium13_1),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 41.h),
                                            child: TextButton(
                                                onPressed: SweetDialogs
                                                    .sendSupportEmail,
                                                child: Text(
                                                    "lbl_support_center".tr,
                                                    style: CustomTextStyles
                                                        .bodyMedium13_1)),
                                          ),
                                        ]))),
                            SizedBox(height: 68.v),
                            SizedBox(
                                height: 335.v,
                                width: double.maxFinite,
                                child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Opacity(
                                          opacity: 0.7,
                                          child: CustomImageView(
                                              imagePath: ImageConstant
                                                  .forgotPasswordCinnamon,
                                              height: 290.v,
                                              width: 302.h,
                                              alignment: Alignment.topLeft)),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgEllipse32,
                                          height: 170.v,
                                          width: 150.h,
                                          alignment: Alignment.bottomRight),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgEllipse33,
                                          height: 200.v,
                                          width: 100.h,
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(top: 16.v))
                                    ]))
                          ]))),
                );
              })),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone(_) {
    getIt<SweetRouterCubit>().state.back();
  }

  void onSubmitCode() async {
    if (codeController.text.isEmpty || passwordController.text.isEmpty) {
      SweetDialogs.alertInfo(
          info: 'Please enter the code sent to your email.',
          title: 'No Verification Code');
      return;
    }
    final resp = await FirebaseAuthService.confirmPasswordReset(
        code: codeController.text, password: passwordController.text);
    if (resp) {
      SweetDialogs.showPasswordResetSuccess();
    }
  }

  /// Send reset password when the action is triggered.
  void onTapSubmit(BuildContext context) async {
    final email = emailController.text;
    if (!EmailValidator.validate(email)) {
      SweetDialogs.alertInfo(
        title: 'Invalid Email',
        info: 'Please enter a valid email address',
      );
      return;
    }
    try {
      controllerStream.add(ForgotStatus.loading);
      await FirebaseAuthService.sendResetPassword(email: email);
      SweetDialogs.alertInfo(
          title: 'Password Reset',
          info:
              'Password reset email sent successfully to: $email go to your email and follow the instructions',
          onConfirm: () {
            getIt<SweetRouterCubit>().popDialogs();
            getIt<SweetRouterCubit>().state.pop();
          });
      emailController.clear();
      controllerStream.add(ForgotStatus.success);
    } catch (e) {
      SweetDialogs.alertInfo(
        title: 'Error',
        info: 'An error occurred while sending the reset password email: $e',
      );
      controllerStream.add(ForgotStatus.error);
    }
  }
}
