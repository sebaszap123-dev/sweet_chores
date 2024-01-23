part of 'sweet_preferences_bloc.dart';

class SweetPreferencesState extends Equatable {
  final bool firstTimeApp;
  final bool autoDeleteTask;
  final ThemeData theme;
  final SweetChoresThemes typeTheme;
  final bool isDarkMode;
  final storageData = getIt<SweetChoresPreferences>();
  final SweetChoresStatus status;
  SweetPreferencesState({
    this.firstTimeApp = true,
    this.autoDeleteTask = false,
    this.isDarkMode = false,
    required this.typeTheme,
    required this.theme,
    this.status = SweetChoresStatus.initial,
  });
  @override
  List<Object> get props => [firstTimeApp, theme, isDarkMode, autoDeleteTask];

  SweetPreferencesState copyWith({
    bool? firstTimeApp,
    bool? autoDeleteTask,
    bool? isDarkMode,
    ThemeData? theme,
    SweetChoresStatus? status,
    SweetChoresThemes? typeTheme,
  }) {
    return SweetPreferencesState(
      firstTimeApp: firstTimeApp ?? this.firstTimeApp,
      theme: theme ?? this.theme,
      status: status ?? this.status,
      typeTheme: typeTheme ?? this.typeTheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      autoDeleteTask: autoDeleteTask ?? this.autoDeleteTask,
    );
  }
}
