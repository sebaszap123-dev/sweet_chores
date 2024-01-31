import 'package:get_it/get_it.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/domain/services/internet_info.dart';
import 'data_source.dart';

GetIt getIt = GetIt.instance;

final router = SweetChoresRouter();

Future<void> serviceLocator() async {
  getIt.registerSingleton(SweetPreferencesBloc());
  final dbManager = await DatabaseManagerCubit.startManager();

  getIt.registerSingleton(FirebaseAuthBloc());
  getIt.registerSingleton(InternetInfo());
  getIt.registerSingleton(dbManager);
  getIt.registerSingleton(TodoBloc());
  getIt.registerSingleton(CategoriesBloc());
  getIt.registerSingleton(SweetRouterCubit(router));
}
