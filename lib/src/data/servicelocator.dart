import 'package:get_it/get_it.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/core/utils/greetings.dart';
import 'package:sweet_chores_reloaded/src/domain/services/internet_info.dart';
import 'data_source.dart';

GetIt getIt = GetIt.instance;

final router = SweetChoresRouter();

void serviceLocator() {
  getIt.registerSingleton(Greeting());
  getIt.registerSingleton(InternetInfo());
  getIt.registerSingleton(SweetChoresPreferences());
  getIt.registerSingleton(SweetPreferencesBloc());
  getIt.registerSingleton(DatabaseManagerCubit());
  getIt.registerSingleton(TodoBloc());
  getIt.registerSingleton(CategoriesBloc());
  getIt.registerSingleton(SweetRouterCubit(router));
}
