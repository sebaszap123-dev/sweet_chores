import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/firebase/firebase_auth_bloc.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

enum RouterStatus { initial, loading, success, error }

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class SweetChoresRouter extends $SweetChoresRouter {
  @override
  List<AutoRoute> get routes => [
        // Change loading page with a page with animation fo cinnamon
        AutoRoute(page: SplashLayout.page, initial: true),
        AutoRoute(page: LoadingRoute.page),
        AutoRoute(page: StartedRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: AuthLayout.page, children: [
          AutoRoute(page: LoginRoute.page),
          AutoRoute(page: RegisterRoute.page),
          AutoRoute(page: ForgotPasswordRoute.page),
        ]),
        AutoRoute(page: ConfigRouteLayout.page, children: [
          AutoRoute(page: SettingsRoute.page),
          AutoRoute(page: BackUpRoute.page),
        ]),
        AutoRoute(page: CategoriesManagerRoute.page),
      ];
}

class SweetRouterCubit extends Cubit<SweetChoresRouter> {
  SweetRouterCubit(super.initialState) {
    redirect();
  }
  User? activeUser;

  bool _hasUser({User? user}) {
    if (user != null) {
      activeUser = user;
      return true;
    }
    if (activeUser != null) {
      return true;
    }
    return false;
  }

  void goHome() {
    final hasUser = _hasUser();
    if (hasUser) {
      state.replace(const HomeRoute());
    } else {
      goLogin();
    }
  }

  void goLogin() => state.replace(const AuthLayout(children: [LoginRoute()]));

  void goWithOutAccount() {
    state.replace(const HomeRoute());
  }

  void redirect() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final firstTime = await getIt<SweetChoresPreferences>().isFirstOpen;
    FirebaseAuth.instance.authStateChanges().listen((event) {
      final hasUser = _hasUser(user: event);
      if (firstTime && !hasUser) {
        state.replace(const StartedRoute());
      } else if (!hasUser) {
        state.replace(const AuthLayout(children: [LoginRoute()]));
      } else {
        getIt<FirebaseAuthBloc>().add(NoPremiumEvent(event!));
        state.replace(const HomeRoute());
      }
    });
  }

  BuildContext? getContext() => state.navigatorKey.currentContext;

  void backPage() => state.pop();

  void popDialogs({bool? value}) =>
      Navigator.of(state.navigatorKey.currentContext!).pop(value);
}
