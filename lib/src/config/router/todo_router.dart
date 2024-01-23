import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/router/todo_router.gr.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';
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
        AutoRoute(page: ConfigRouteLayout.page, children: [
          AutoRoute(page: SettingsRoute.page),
          AutoRoute(page: BackUpRoute.page),
        ]),
        AutoRoute(page: CategoriesManagerRoute.page),
        AutoRoute(page: RegisterRoute.page),
      ];
}

class SweetRouterCubit extends Cubit<SweetChoresRouter> {
  SweetRouterCubit(super.initialState) {
    redirect();
  }
  void redirect() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final firstTime = await getIt<SweetChoresPreferences>().isFirstOpen;
    getIt<DatabaseManagerCubit>()
        .stream
        .firstWhere((data) => data.status == DatabaseStatus.ready)
        .then((_) {
      if (firstTime) {
        state.replace(const StartedRoute());
      } else {
        state.replace(const HomeRoute());
      }
    });
  }

  BuildContext? getContext() => state.navigatorKey.currentContext;

  void backPage() => state.pop();

  void popDialogs({bool? value}) =>
      Navigator.of(state.navigatorKey.currentContext!).pop(value);
}
