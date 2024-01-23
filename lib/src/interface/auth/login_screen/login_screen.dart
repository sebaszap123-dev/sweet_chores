import 'package:auto_route/auto_route.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';

import 'bloc/login_bloc.dart';
import 'models/login_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(LoginState(loginModelObj: const LoginModel()))
              ..add(LoginInitialEvent()),
        child: const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 15.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.only(left: 28.h),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          svgPath: ImageConstant.imgArrowleft,
                                          height: 30.v,
                                          width: 18.h,
                                          margin:
                                              EdgeInsets.only(bottom: 225.v),
                                          onTap: () {
                                            onTapImgArrowleftone(context);
                                          }),
                                      Opacity(
                                          opacity: 0.7,
                                          child: CustomImageView(
                                              imagePath: ImageConstant
                                                  .imgImg1127photoroom,
                                              height: 255.v,
                                              width: 272.h,
                                              margin:
                                                  EdgeInsets.only(left: 71.h)))
                                    ]))),
                        Padding(
                            padding: EdgeInsets.only(left: 40.h, top: 13.v),
                            child: Text("lbl_log_in".tr,
                                style: theme.textTheme.headlineSmall)),
                        SizedBox(height: 1.v),
                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                height: 339.v,
                                width: 310.h,
                                child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.h),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("lbl_email".tr,
                                                        style: theme.textTheme
                                                            .bodyMedium),
                                                    SizedBox(height: 5.v),
                                                    BlocSelector<
                                                            LoginBloc,
                                                            LoginState,
                                                            TextEditingController?>(
                                                        selector: (state) => state
                                                            .edittextController,
                                                        builder: (context,
                                                            edittextController) {
                                                          return CustomTextFormField(
                                                              controller:
                                                                  edittextController);
                                                        }),
                                                    SizedBox(height: 18.v),
                                                    Text("lbl_password".tr,
                                                        style: theme.textTheme
                                                            .bodyMedium),
                                                    SizedBox(height: 5.v),
                                                    BlocSelector<
                                                            LoginBloc,
                                                            LoginState,
                                                            TextEditingController?>(
                                                        selector: (state) => state
                                                            .passwordController,
                                                        builder: (context,
                                                            passwordController) {
                                                          return CustomTextFormField(
                                                              controller:
                                                                  passwordController,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .done,
                                                              obscureText:
                                                                  true);
                                                        }),
                                                    SizedBox(height: 13.v),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              onTapTxtForgotpassword(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "msg_forgot_password"
                                                                    .tr,
                                                                style: theme
                                                                    .textTheme
                                                                    .titleSmall))),
                                                    SizedBox(height: 40.v),
                                                    CustomElevatedButton(
                                                        text: "lbl_login2".tr),
                                                    SizedBox(height: 14.v),
                                                    GestureDetector(
                                                        onTap: () {
                                                          onTapTxtNewhereregister(
                                                              context);
                                                        },
                                                        child: RichText(
                                                            text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                      text: "lbl_new_here"
                                                                          .tr,
                                                                      style: CustomTextStyles
                                                                          .bodyMedium13),
                                                                  const TextSpan(
                                                                      text:
                                                                          " "),
                                                                  TextSpan(
                                                                      text: "lbl_register"
                                                                          .tr,
                                                                      style: CustomTextStyles
                                                                          .labelLargeSFProText)
                                                                ]),
                                                            textAlign:
                                                                TextAlign.left))
                                                  ]))),
                                      Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 105.v),
                                              child: Row(children: [
                                                CustomIconButton(
                                                    height: 45.adaptSize,
                                                    width: 45.adaptSize,
                                                    padding:
                                                        EdgeInsets.all(9.h),
                                                    child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgFlatcoloriconsgoogle)),
                                                CustomIconButton(
                                                    height: 45.adaptSize,
                                                    width: 45.adaptSize,
                                                    margin: EdgeInsets.only(
                                                        left: 16.h),
                                                    padding:
                                                        EdgeInsets.all(9.h),
                                                    child: CustomImageView(
                                                      svgPath: ImageConstant
                                                          .imgAntdesignapplefilled,
                                                    ))
                                              ])))
                                    ]))),
                        SizedBox(height: 18.v),
                        SizedBox(
                            height: 206.v,
                            width: double.maxFinite,
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.imgEllipse29,
                                      height: 180.v,
                                      width: 149.h,
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.only(bottom: 10.v)),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                          height: 150.adaptSize,
                                          width: 150.adaptSize,
                                          decoration: BoxDecoration(
                                              color: appTheme.blue100,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      75.h)))),
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: 150.adaptSize,
                                          width: 150.adaptSize,
                                          decoration: BoxDecoration(
                                              color: appTheme.blue100,
                                              borderRadius:
                                                  BorderRadius.circular(75.h))))
                                ]))
                      ])))
                ]))));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgArrowleftone(BuildContext context) {
    // AUTH: NAVIGATION WHEN IMPLEMENT
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the forgotPasswordScreen.
  onTapTxtForgotpassword(BuildContext context) {
    // AUTH: NAVIGATION WHEN IMPLEMENT
  }

  /// Navigates to the registerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the registerScreen.
  onTapTxtNewhereregister(BuildContext context) {
    // AUTH: NAVIGATION WHEN IMPLEMENT
  }
}
