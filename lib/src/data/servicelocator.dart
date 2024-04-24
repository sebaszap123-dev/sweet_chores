import 'package:get_it/get_it.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/greetings.dart';
import 'data_source.dart';

GetIt getIt = GetIt.instance;

final router = SweetChoresRouter();

Future<void> serviceLocator() async {
  getIt.registerSingleton(NetworkInfo());
  getIt.registerSingleton(SweetPreferencesBloc());
  getIt.registerSingleton(Greetings());
  final dbManager = await DatabaseManagerCubit.startManager();
  getIt.registerSingleton(SweetRouterCubit(router));
  getIt.registerSingleton(FirebaseAuthBloc());
  getIt.registerSingleton(dbManager);
  getIt.registerSingleton(SweetChoresNotesBloc());
}
