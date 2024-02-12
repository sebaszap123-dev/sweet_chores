// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/checker_wifi.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/services.dart';
import 'package:sweet_chores/src/interface/common/common.dart';

import 'bloc/login_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (blockContext) =>
          LoginBloc(LoginState())..add(LoginInitialEvent()),
      child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? const Loading()
              : SizedBox(
                  width: double.maxFinite,
                  child: Column(children: [
                    SizedBox(height: 15.v),
                    Expanded(
                        child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 28.h),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Opacity(
                                                    opacity: 0.7,
                                                    child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .loginCinnamon,
                                                        height: 255.v,
                                                        width: 272.h,
                                                        margin: EdgeInsets.only(
                                                            left: 71.h)))
                                              ]))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 40.h, top: 13.v),
                                      child: Text(
                                        "lbl_log_in".tr,
                                        style: GoogleFonts.spicyRice(
                                          color: appAutoGeneraterTheme.blue100,
                                          fontSize: 40,
                                        ),
                                      )),
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
                                                            EdgeInsets.only(
                                                                left: 1.h),
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "lbl_email".tr,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color: appAutoGeneraterTheme
                                                                      .blue100,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5.v),
                                                              BlocSelector<
                                                                      LoginBloc,
                                                                      LoginState,
                                                                      TextEditingController?>(
                                                                  selector:
                                                                      (state) =>
                                                                          state
                                                                              .editEmailController,
                                                                  builder: (context,
                                                                      editEmailController) {
                                                                    return CustomTextFormField(
                                                                        controller:
                                                                            editEmailController);
                                                                  }),
                                                              SizedBox(
                                                                  height: 18.v),
                                                              Text(
                                                                "lbl_password"
                                                                    .tr,
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium
                                                                    ?.copyWith(
                                                                  color: appAutoGeneraterTheme
                                                                      .blue100,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5.v),
                                                              BlocSelector<
                                                                      LoginBloc,
                                                                      LoginState,
                                                                      TextEditingController?>(
                                                                  selector:
                                                                      (state) =>
                                                                          state
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
                                                              SizedBox(
                                                                  height: 13.v),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    onTapTxtForgotpassword(
                                                                      context,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    "msg_forgot_password"
                                                                        .tr,
                                                                    style: theme
                                                                        .textTheme
                                                                        .titleSmall
                                                                        ?.copyWith(
                                                                      color: appAutoGeneraterTheme
                                                                          .blue100,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 40.v),
                                                              BlocSelector<
                                                                      LoginBloc,
                                                                      LoginState,
                                                                      LoginState?>(
                                                                  selector:
                                                                      (state) =>
                                                                          state,
                                                                  builder: (context,
                                                                      fullState) {
                                                                    return CustomElevatedButton(
                                                                      onTap: () => _onLoginWithEmail(
                                                                          context,
                                                                          fullState),
                                                                      buttonStyle:
                                                                          ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all(appAutoGeneraterTheme.blue100),
                                                                      ),
                                                                      text: "lbl_login2"
                                                                          .tr,
                                                                      buttonTextStyle:
                                                                          const TextStyle(
                                                                              color: Colors.white),
                                                                    );
                                                                  }),
                                                              SizedBox(
                                                                  height: 14.v),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    onTapTxtNewhereregister(
                                                                        context);
                                                                  },
                                                                  child: RichText(
                                                                      text: TextSpan(children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "lbl_new_here".tr,
                                                                            style: CustomTextStyles.bodyMedium13),
                                                                        const TextSpan(
                                                                            text:
                                                                                " "),
                                                                        TextSpan(
                                                                            text:
                                                                                "lbl_register".tr,
                                                                            style: CustomTextStyles.labelLargeSFProText)
                                                                      ]),
                                                                      textAlign: TextAlign.left))
                                                            ]))),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 105.v),
                                                    child: Row(
                                                      children: [
                                                        CustomIconButton(
                                                            height:
                                                                45.adaptSize,
                                                            width: 45.adaptSize,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    9.h),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onTap: () =>
                                                                onTapLoginWithGoogle(
                                                                  context,
                                                                ),
                                                            child: CustomImageView(
                                                                svgPath:
                                                                    ImageConstant
                                                                        .imgFlatcoloriconsgoogle)),
                                                        // * TODO-feature: ADD LOGIN APPLE
                                                        // CustomIconButton(
                                                        //     height: 45.adaptSize,
                                                        //     width: 45.adaptSize,
                                                        //     decoration: const BoxDecoration(
                                                        //       color: Colors.white,
                                                        //     ),
                                                        //     margin:
                                                        //         EdgeInsets.only(left: 16.h),
                                                        //     padding: EdgeInsets.all(9.h),
                                                        //     child: CustomImageView(
                                                        //       svgPath: ImageConstant
                                                        //           .imgAntdesignapplefilled,
                                                        //     )),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ]))),
                                  SizedBox(height: 18.v),
                                  SizedBox(
                                      height: 210.v,
                                      width: double.maxFinite,
                                      child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgEllipse29,
                                                height: 180.v,
                                                width: 149.h,
                                                alignment:
                                                    Alignment.bottomRight,
                                                margin: EdgeInsets.only(
                                                    bottom: 10.v)),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                    height: 150.adaptSize,
                                                    width: 150.adaptSize,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            appAutoGeneraterTheme
                                                                .blue100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    75.h)))),
                                            Align(
                                                alignment: Alignment
                                                    .bottomCenter,
                                                child: Container(
                                                    height: 190.adaptSize,
                                                    width: 150.adaptSize,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            appAutoGeneraterTheme
                                                                .blue100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    75.h))))
                                          ]))
                                ])))
                  ]))),
    );
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the forgotPasswordScreen.
  onTapTxtForgotpassword(BuildContext context) async {
    final hasInternet = await checkInternetState(scaffoldKey, context);
    if (hasInternet) {
      getIt<SweetRouterCubit>()
          .state
          .push(const AuthLayout(children: [ForgotPasswordRoute()]));
    } else {}
  }

  void onTapLoginWithGoogle(BuildContext context) async {
    final hasInternet = await checkInternetState(scaffoldKey, context);

    if (hasInternet) {
      setState(() {
        isLoading = true;
      });
      final resp = await FirebaseAuthService.loginWithGoogle();
      if (mounted) {
        setState(() {
          isLoading = resp;
        });
      }
    } else {
      checkInternetState(scaffoldKey, context);
    }
  }

  void _onLoginWithEmail(BuildContext context, LoginState? state) async {
    final hasInternet = await checkInternetState(scaffoldKey, context);
    if (hasInternet) {
      final email = state?.editEmailController?.text;
      final password = state?.passwordController?.text;
      if (email == null || email.isEmpty) {
        SweetDialogs.alertInfo(
            info: 'The email is required', title: 'Fields required');
        return;
      }
      if (password == null || password.isEmpty) {
        SweetDialogs.alertInfo(
            info: 'The email is required', title: 'Fields required');
        return;
      }
      if (email.isNotEmpty && password.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuthService.loginWithEmailAndPw(
            email: email, password: password);
      }
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Navigates to the registerScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [NavigatorService]
  /// to push the named route for the registerScreen.
  onTapTxtNewhereregister(BuildContext context) {
    getIt<SweetRouterCubit>()
        .state
        .push(const AuthLayout(children: [RegisterRoute()]));
  }
}
