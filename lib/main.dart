import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/localization/app_localization.dart';

import 'src/config/remote/firebase_database.dart';

final globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseDatabase.initFirebase();
  serviceLocator();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then((value) {
    runApp(const MyBlocApp());
  });
}

class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseManagerCubit>(
          create: (_) => getIt<DatabaseManagerCubit>(),
        ),
        BlocProvider<TodoBloc>(
          create: (_) => getIt<TodoBloc>()..add(TodoStarted()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (_) => getIt<CategoriesBloc>()..add(const CategoryStarted()),
        ),
        BlocProvider<SweetPreferencesBloc>(
          create: (_) =>
              getIt<SweetPreferencesBloc>()..add(const InitalStatusSweetCh()),
        ),
        BlocProvider<SweetRouterCubit>(
          create: (_) => getIt<SweetRouterCubit>(),
        ),
      ],
      child: const SweetChoresApp(),
    );
  }
}

class SweetChoresApp extends StatelessWidget {
  const SweetChoresApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<SweetPreferencesBloc>().state.themeData;

    return BlocBuilder<SweetRouterCubit, SweetChoresRouter>(
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: state.config(),
          debugShowCheckedModeBanner: false,
          title: 'Sweet Chores',
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
              '',
            ),
          ],
          theme: theme,
        );
      },
    );
  }
}
