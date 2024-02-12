import 'package:auto_route/auto_route.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/checker_wifi.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/services.dart';
import 'package:sweet_chores/src/interface/common/common.dart';

import 'bloc/register_bloc.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: BlocProvider(
      create: (context) =>
          RegisterBloc(RegisterState())..add(RegisterInitialEvent()),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? const Loading()
              : SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        SizedBox(
                            height: 240.v,
                            width: double.maxFinite,
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 40.h),
                                      child: Text("lbl_register".tr,
                                          style:
                                              theme.textTheme.headlineSmall))),
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
                                                    alignment:
                                                        Alignment.center)),
                                            CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgArrowleft,
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
                                  autofocus: false,
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
                                  autofocus: false,
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
                                  autofocus: false,
                                  controller: passwordController,
                                  margin: EdgeInsets.only(
                                      left: 40.h, top: 5.v, right: 41.h),
                                  textInputAction: TextInputAction.done,
                                  alignment: Alignment.center,
                                  obscureText: true);
                            }),
                        Padding(
                            padding: EdgeInsets.only(left: 39.h, top: 20.v),
                            child: Text('Or register with',
                                style: CustomTextStyles.labelLargeSFProText)),
                        Padding(
                            padding: EdgeInsets.only(left: 39.h, top: 10.v),
                            child: Row(children: [
                              CustomIconButton(
                                  height: 45.adaptSize,
                                  width: 45.adaptSize,
                                  padding: EdgeInsets.all(9.h),
                                  child: CustomImageView(
                                      svgPath: ImageConstant
                                          .imgFlatcoloriconsgoogle)),
                              CustomIconButton(
                                  height: 45.adaptSize,
                                  width: 45.adaptSize,
                                  margin: EdgeInsets.only(left: 16.h),
                                  padding: EdgeInsets.all(9.h),
                                  child: CustomImageView(
                                      svgPath: ImageConstant
                                          .imgAntdesignapplefilled))
                            ])),
                        BlocSelector<RegisterBloc, RegisterState,
                                RegisterState?>(
                            selector: (state) => state,
                            builder: (context, registerState) {
                              return CustomElevatedButton(
                                  text: "lbl_register".tr,
                                  margin: EdgeInsets.only(
                                      left: 40.h, top: 35.v, right: 41.h),
                                  onTap: () {
                                    onTapRegister(context, registerState);
                                  },
                                  alignment: Alignment.center);
                            }),
                        SizedBox(height: 14.v),
                        SizedBox(
                            height: 245.v,
                            width: double.maxFinite,
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  CustomImageView(
                                      imagePath:
                                          ImageConstant.imgEllipse29150x101,
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
                                              color:
                                                  appAutoGeneraterTheme.blue100,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      75.h)))),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                          height: 150.adaptSize,
                                          width: 150.adaptSize,
                                          margin: EdgeInsets.only(left: 75.h),
                                          decoration: BoxDecoration(
                                              color:
                                                  appAutoGeneraterTheme.blue100,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      75.h)))),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: GestureDetector(
                                          onTap: () {
                                            onTapTxtAlreadymember(context);
                                          },
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 40.h),
                                              child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "lbl_already_member"
                                                                .tr,
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
  onTapImgArrowleftone(_) {
    getIt<SweetRouterCubit>().backPage();
  }

  /// Register a user
  void onTapRegister(BuildContext context, RegisterState? currentState) async {
    final hasInternet = await checkInternetState(scaffoldKey, context);
    if (!hasInternet) return;
    final email = currentState?.emailController?.text;
    final password = currentState?.passwordController?.text;
    final name = currentState?.edittextController?.text;

    if (email == null || email.isEmpty) {
      SweetDialogs.alertInfo(
          info: 'The email is required', title: 'Fields required');
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (password == null || password.isEmpty) {
      SweetDialogs.alertInfo(
          info: 'The password is required', title: 'Fields required');
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (name == null || name.isEmpty) {
      SweetDialogs.alertInfo(
          info: 'The name is required', title: 'Fields required');
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuthService.registerWithEmailAndPw(
        email: email,
        password: password,
        fullName: name,
      );
    } catch (e) {
      SweetDialogs.alertInfo(
          info: 'Error registering user: $e', title: 'Registration Error');
    } finally {
      if (mounted && isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtAlreadymember(_) {
    getIt<SweetRouterCubit>()
        .state
        .push(const AuthLayout(children: [LoginRoute()]));
  }
}
