import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sweet_chores/firebase_options.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/localization/app_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

final globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await serviceLocator();
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
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
        BlocProvider<SweetChoresNotesBloc>(
          create: (_) => getIt<SweetChoresNotesBloc>(),
        ),
        BlocProvider<SweetPreferencesBloc>(
          create: (_) =>
              getIt<SweetPreferencesBloc>()..add(const InitalStatusSweetCh()),
          lazy: false,
        ),
        BlocProvider<SweetRouterCubit>(
          create: (_) => getIt<SweetRouterCubit>(),
        ),
        BlocProvider<FirebaseAuthBloc>(
          create: (_) => getIt<FirebaseAuthBloc>(),
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
