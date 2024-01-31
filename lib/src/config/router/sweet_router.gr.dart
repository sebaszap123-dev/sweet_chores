// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:sweet_chores_reloaded/src/interface/auth/auth_router_screen.dart'
    as _i3;
import 'package:sweet_chores_reloaded/src/interface/auth/forgot_password_screen/forgot_password_screen.dart'
    as _i6;
import 'package:sweet_chores_reloaded/src/interface/auth/home/auth_home_screen.dart'
    as _i1;
import 'package:sweet_chores_reloaded/src/interface/auth/login_screen/login_screen.dart'
    as _i10;
import 'package:sweet_chores_reloaded/src/interface/auth/register_screen/register_screen.dart'
    as _i11;
import 'package:sweet_chores_reloaded/src/interface/config/layout/config_route_layout.dart'
    as _i5;
import 'package:sweet_chores_reloaded/src/interface/config/views/settings_screen.dart'
    as _i12;
import 'package:sweet_chores_reloaded/src/interface/home/home_router.dart'
    as _i7;
import 'package:sweet_chores_reloaded/src/interface/home/views/categories_manager_screen.dart'
    as _i4;
import 'package:sweet_chores_reloaded/src/interface/home/views/home_screen.dart'
    as _i8;
import 'package:sweet_chores_reloaded/src/interface/layout/auth_layout.dart'
    as _i2;
import 'package:sweet_chores_reloaded/src/interface/layout/splash_layout.dart'
    as _i13;
import 'package:sweet_chores_reloaded/src/interface/layout/started_screen.dart'
    as _i14;
import 'package:sweet_chores_reloaded/src/interface/loading_screen.dart' as _i9;
import 'package:sweet_chores_reloaded/src/models/categories.dart' as _i17;

abstract class $SweetChoresRouter extends _i15.RootStackRouter {
  $SweetChoresRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AuthHomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthHomeScreen(),
      );
    },
    AuthLayout.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AuthLayout(),
      );
    },
    AuthRouterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AuthRouterScreen(),
      );
    },
    CategoriesManagerRoute.name: (routeData) {
      final args = routeData.argsAs<CategoriesManagerRouteArgs>(
          orElse: () => const CategoriesManagerRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CategoriesManagerScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    ConfigRouteLayout.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ConfigRouteLayout(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ForgotPasswordScreen(),
      );
    },
    HomeRouterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeRouterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomeScreen(),
      );
    },
    LoadingRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoadingScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.RegisterScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsScreen(),
      );
    },
    SplashLayout.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SplashLayout(),
      );
    },
    StartedRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.StartedScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthHomeScreen]
class AuthHomeRoute extends _i15.PageRouteInfo<void> {
  const AuthHomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthHomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AuthLayout]
class AuthLayout extends _i15.PageRouteInfo<void> {
  const AuthLayout({List<_i15.PageRouteInfo>? children})
      : super(
          AuthLayout.name,
          initialChildren: children,
        );

  static const String name = 'AuthLayout';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AuthRouterScreen]
class AuthRouterRoute extends _i15.PageRouteInfo<void> {
  const AuthRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CategoriesManagerScreen]
class CategoriesManagerRoute
    extends _i15.PageRouteInfo<CategoriesManagerRouteArgs> {
  CategoriesManagerRoute({
    _i16.Key? key,
    _i17.Categories? category,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CategoriesManagerRoute.name,
          args: CategoriesManagerRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoriesManagerRoute';

  static const _i15.PageInfo<CategoriesManagerRouteArgs> page =
      _i15.PageInfo<CategoriesManagerRouteArgs>(name);
}

class CategoriesManagerRouteArgs {
  const CategoriesManagerRouteArgs({
    this.key,
    this.category,
  });

  final _i16.Key? key;

  final _i17.Categories? category;

  @override
  String toString() {
    return 'CategoriesManagerRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i5.ConfigRouteLayout]
class ConfigRouteLayout extends _i15.PageRouteInfo<void> {
  const ConfigRouteLayout({List<_i15.PageRouteInfo>? children})
      : super(
          ConfigRouteLayout.name,
          initialChildren: children,
        );

  static const String name = 'ConfigRouteLayout';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i15.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeRouterScreen]
class HomeRouterRoute extends _i15.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoadingScreen]
class LoadingRoute extends _i15.PageRouteInfo<void> {
  const LoadingRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoadingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RegisterScreen]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SettingsScreen]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SplashLayout]
class SplashLayout extends _i15.PageRouteInfo<void> {
  const SplashLayout({List<_i15.PageRouteInfo>? children})
      : super(
          SplashLayout.name,
          initialChildren: children,
        );

  static const String name = 'SplashLayout';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.StartedScreen]
class StartedRoute extends _i15.PageRouteInfo<void> {
  const StartedRoute({List<_i15.PageRouteInfo>? children})
      : super(
          StartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartedRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
