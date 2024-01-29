import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/core/utils/image_constant.dart';
import 'package:sweet_chores_reloaded/src/core/utils/size_utils.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/localization/app_localization.dart';
import 'package:sweet_chores_reloaded/src/theme/custom_text_style.dart';
import 'package:sweet_chores_reloaded/src/theme/theme_helper.dart';
import 'package:sweet_chores_reloaded/src/widgets/custom_elevated_button.dart';
import 'package:sweet_chores_reloaded/src/widgets/custom_image_view.dart';
import 'package:sweet_chores_reloaded/src/widgets/custom_text_form_field.dart';

import 'bloc/forgot_password_bloc.dart';
import 'models/forgot_password_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (context) => ForgotPasswordBloc(ForgotPasswordState(
          forgotPasswordModelObj: const ForgotPasswordModel()))
        ..add(ForgotPasswordInitialEvent()),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: DefaultTextStyle(
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
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgEllipse2931x150,
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
                                              alignment: Alignment.center),
                                          CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgArrowleftOnprimary,
                                              height: 30.v,
                                              width: 18.h,
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 28.h, top: 15.v),
                                              onTap: () {
                                                onTapImgArrowleftone(context);
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
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          width: 249.h,
                          margin: EdgeInsets.only(left: 40.h),
                          child: Text(
                            "msg_enter_the_email".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 43.h, top: 17.v),
                          child: Text(
                            "msg_email_or_phone_number".tr,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )),
                      BlocSelector<ForgotPasswordBloc, ForgotPasswordState,
                              TextEditingController?>(
                          selector: (state) => state.phoneNumberController,
                          builder: (context, phoneNumberController) {
                            return CustomTextFormField(
                                controller: phoneNumberController,
                                margin: EdgeInsets.only(
                                    left: 40.h, top: 10.v, right: 41.h),
                                textInputAction: TextInputAction.done,
                                alignment: Alignment.center);
                          }),
                      CustomElevatedButton(
                          text: "lbl_submit".tr,
                          buttonStyle: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  appAutoGeneraterTheme.blue100)),
                          buttonTextStyle: const TextStyle(color: Colors.white),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("msg_forgot_email_or".tr,
                                        style: CustomTextStyles.bodyMedium13_1),
                                    Padding(
                                        padding: EdgeInsets.only(left: 41.h),
                                        child: Text("lbl_support_center".tr,
                                            style: CustomTextStyles
                                                .bodyMedium13_1))
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
                                        imagePath:
                                            ImageConstant.imgImg1124photoroom,
                                        height: 270.v,
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
          )),
    ));
  }

  /// Navigates to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is
  /// used to build the navigation stack. When the action is triggered, this
  /// function uses the [NavigatorService] to navigate to the previous screen
  /// in the navigation stack.
  onTapImgArrowleftone(BuildContext context) {
    getIt<SweetRouterCubit>().state.back();
  }

  /// Navigates to the loginScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the loginScreen.
  onTapSubmit(BuildContext context) {
    // TODO AUTH: DO THE RESET OF PASSWORD
  }
}
