import 'package:auto_route/auto_route.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';

import 'bloc/register_bloc.dart';
import 'models/register_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: BlocProvider(
      create: (context) =>
          RegisterBloc(RegisterState(registerModelObj: const RegisterModel()))
            ..add(RegisterInitialEvent()),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(
                        height: 240.v,
                        width: double.maxFinite,
                        child: Stack(alignment: Alignment.center, children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 40.h),
                                  child: Text("lbl_register".tr,
                                      style: theme.textTheme.headlineSmall))),
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  height: 240.v,
                                  width: double.maxFinite,
                                  child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Opacity(
                                            opacity: 0.7,
                                            child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .registerCinnamon,
                                                height: 240.v,
                                                width: 390.h,
                                                alignment: Alignment.center)),
                                        CustomImageView(
                                            svgPath: ImageConstant.imgArrowleft,
                                            height: 30.v,
                                            width: 18.h,
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(
                                                left: 28.h, top: 15.v),
                                            onTap: () {
                                              onTapImgArrowleftone(context);
                                            })
                                      ])))
                        ])),
                    Padding(
                        padding: EdgeInsets.only(left: 40.h, top: 1.v),
                        child: Text("lbl_full_name".tr,
                            style: theme.textTheme.bodyMedium)),
                    BlocSelector<RegisterBloc, RegisterState,
                            TextEditingController?>(
                        selector: (state) => state.edittextController,
                        builder: (context, edittextController) {
                          return CustomTextFormField(
                              controller: edittextController,
                              margin: EdgeInsets.only(
                                  left: 40.h, top: 5.v, right: 41.h),
                              alignment: Alignment.center);
                        }),
                    Padding(
                        padding: EdgeInsets.only(left: 40.h, top: 15.v),
                        child: Text("lbl_email".tr,
                            style: theme.textTheme.bodyMedium)),
                    BlocSelector<RegisterBloc, RegisterState,
                            TextEditingController?>(
                        selector: (state) => state.emailController,
                        builder: (context, emailController) {
                          return CustomTextFormField(
                              controller: emailController,
                              margin: EdgeInsets.only(
                                  left: 40.h, top: 5.v, right: 41.h),
                              alignment: Alignment.center);
                        }),
                    Padding(
                        padding: EdgeInsets.only(left: 40.h, top: 18.v),
                        child: Text("lbl_password".tr,
                            style: theme.textTheme.bodyMedium)),
                    BlocSelector<RegisterBloc, RegisterState,
                            TextEditingController?>(
                        selector: (state) => state.passwordController,
                        builder: (context, passwordController) {
                          return CustomTextFormField(
                              controller: passwordController,
                              margin: EdgeInsets.only(
                                  left: 40.h, top: 5.v, right: 41.h),
                              textInputAction: TextInputAction.done,
                              alignment: Alignment.center,
                              obscureText: true);
                        }),
                    Padding(
                        padding: EdgeInsets.only(left: 39.h, top: 30.v),
                        child: Row(children: [
                          CustomIconButton(
                              height: 45.adaptSize,
                              width: 45.adaptSize,
                              padding: EdgeInsets.all(9.h),
                              child: CustomImageView(
                                  svgPath:
                                      ImageConstant.imgFlatcoloriconsgoogle)),
                          CustomIconButton(
                              height: 45.adaptSize,
                              width: 45.adaptSize,
                              margin: EdgeInsets.only(left: 16.h),
                              padding: EdgeInsets.all(9.h),
                              child: CustomImageView(
                                  svgPath:
                                      ImageConstant.imgAntdesignapplefilled))
                        ])),
                    CustomElevatedButton(
                        text: "lbl_register".tr,
                        margin:
                            EdgeInsets.only(left: 40.h, top: 35.v, right: 41.h),
                        onTap: () {
                          onTapRegister(context);
                        },
                        alignment: Alignment.center),
                    SizedBox(height: 14.v),
                    SizedBox(
                        height: 245.v,
                        width: double.maxFinite,
                        child:
                            Stack(alignment: Alignment.bottomLeft, children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgEllipse29150x101,
                              height: 150.v,
                              width: 101.h,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 16.v)),
                          CustomImageView(
                              imagePath: ImageConstant.imgEllipse30,
                              height: 150.v,
                              width: 105.h,
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(bottom: 35.v)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  height: 150.adaptSize,
                                  width: 150.adaptSize,
                                  margin: EdgeInsets.only(
                                      right: 34.h, bottom: 12.v),
                                  decoration: BoxDecoration(
                                      color: appAutoGeneraterTheme.blue100,
                                      borderRadius:
                                          BorderRadius.circular(75.h)))),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                  height: 150.adaptSize,
                                  width: 150.adaptSize,
                                  margin: EdgeInsets.only(left: 75.h),
                                  decoration: BoxDecoration(
                                      color: appAutoGeneraterTheme.blue100,
                                      borderRadius:
                                          BorderRadius.circular(75.h)))),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                  onTap: () {
                                    onTapTxtAlreadymember(context);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 40.h),
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "lbl_already_member".tr,
                                                style: CustomTextStyles
                                                    .bodyMedium13),
                                            const TextSpan(text: " "),
                                            TextSpan(
                                                text: "lbl_login2".tr,
                                                style: CustomTextStyles
                                                    .labelLargeSFProText)
                                          ]),
                                          textAlign: TextAlign.left))))
                        ]))
                  ])))),
    ));
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

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the loginScreen.
  onTapRegister(BuildContext context) {
    // AUTH: NAVIGATION WHEN IMPLEMENT
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the loginScreen.
  onTapTxtAlreadymember(BuildContext context) {
    // AUTH: NAVIGATION WHEN IMPLEMENT
  }
}
