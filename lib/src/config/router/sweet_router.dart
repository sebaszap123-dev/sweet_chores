import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/config/router/guards/home_guard.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';

enum RouterStatus { initial, loading, success, error }

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class SweetChoresRouter extends $SweetChoresRouter {
  @override
  List<AutoRoute> get routes => [
        // Change loading page with a page with animation fo cinnamon
        AutoRoute(page: SplashLayout.page, initial: true),
        AutoRoute(page: LoadingRoute.page),
        AutoRoute(page: StartedRoute.page),
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: AuthLayout.page, children: [
          AutoRoute(page: LoginRoute.page),
          AutoRoute(page: RegisterRoute.page),
          AutoRoute(page: ForgotPasswordRoute.page),
          AutoRoute(page: DeleteAccountRoute.page),
        ]),
        AutoRoute(page: ConfigRouteLayout.page, guards: [
          AuthGuard()
        ], children: [
          AutoRoute(page: SettingsRoute.page),
        ]),
        AutoRoute(page: CategoriesManagerRoute.page, guards: [AuthGuard()]),
      ];
}

class SweetRouterCubit extends Cubit<SweetChoresRouter> {
  SweetRouterCubit(super.initialState) {
    redirect();
  }
  User? activeUser;

  void goHome() {
    if (FirebaseAuth.instance.currentUser != null) {
      state.replace(const HomeRoute());
    } else {
      goLogin();
    }
  }

  void goLogin() => state.replace(const AuthLayout(children: [LoginRoute()]));

  void deleteAccount() => state.popAndPushAll([
        const AuthLayout(children: [LoginRoute()])
      ]);

  void redirect() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final firstTime = await SweetSecurePreferences.isFirstOpen;
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (firstTime && event == null) {
        state.replace(const StartedRoute());
      } else if (event == null) {
        getIt<FirebaseAuthBloc>().add(AuthLogOut());
        state.replace(const AuthLayout(children: [LoginRoute()]));
      } else {
        // * TODO-FEATURE: HANDLE PREMIUM DATA
        getIt<FirebaseAuthBloc>().add(
          AuthLoginEvent(
              user: event, premium: false, isNew: firstTime, isRouting: true),
        );
        getIt<TodoBloc>().add(TodoStarted());
        getIt<CategoriesBloc>().add(const CategoryStarted());
        state.replace(const HomeRoute());
      }
    });
  }

  BuildContext? getContext() => state.navigatorKey.currentContext;

  void backPage() => state.pop();

  void popDialogs({bool? value}) =>
      Navigator.of(state.navigatorKey.currentContext!).pop(value);
}
