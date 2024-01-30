part of 'sweet_preferences_bloc.dart';

class SweetPreferencesState extends Equatable {
  final bool firstTimeApp;
  final bool autoDeleteTask;
  final ThemeData themeData;
  final SweetThemeColors themeColors;
  final SweetTheme typeTheme;
  final bool isDarkMode;
  final SweetChoresStatus status;
  const SweetPreferencesState({
    required this.themeColors,
    this.firstTimeApp = true,
    this.autoDeleteTask = false,
    this.isDarkMode = false,
    this.typeTheme = SweetTheme.cinnamon,
    required this.themeData,
    this.status = SweetChoresStatus.initial,
  });
  @override
  List<Object> get props =>
      [firstTimeApp, themeData, isDarkMode, autoDeleteTask];

  SweetPreferencesState copyWith({
    bool? firstTimeApp,
    bool? autoDeleteTask,
    bool? isDarkMode,
    ThemeData? themeData,
    SweetChoresStatus? status,
    SweetTheme? typeTheme,
    SweetThemeColors? themeColors,
  }) {
    return SweetPreferencesState(
      firstTimeApp: firstTimeApp ?? this.firstTimeApp,
      themeData: themeData ?? this.themeData,
      status: status ?? this.status,
      typeTheme: typeTheme ?? this.typeTheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      autoDeleteTask: autoDeleteTask ?? this.autoDeleteTask,
      themeColors: themeColors ?? this.themeColors,
    );
  }

  static SweetPreferencesState get instance {
    final colors = SweetThemeColors.fromDefault();
    final themeData = SweetThemes.sweetThemeData(themeColors: colors);
    return SweetPreferencesState(
      themeColors: colors,
      themeData: themeData,
    );
  }
}
