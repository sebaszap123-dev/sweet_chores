part of 'sweet_preferences_bloc.dart';

class SweetPreferencesState extends Equatable {
  final bool firstTimeApp;
  final bool isActiveAutoDelete;
  final bool isDarkMode;
  final bool isActiveBackup;
  final ThemeData themeData;
  final SweetThemeColors themeColors;
  final SweetTheme typeTheme;
  final SweetChoresStatus status;

  const SweetPreferencesState({
    required this.themeColors,
    this.firstTimeApp = true,
    this.isActiveAutoDelete = false,
    this.isDarkMode = false,
    this.isActiveBackup = false,
    this.typeTheme = SweetTheme.cinnamon,
    required this.themeData,
    this.status = SweetChoresStatus.initial,
  });
  @override
  List<Object> get props =>
      [firstTimeApp, themeData, isDarkMode, isActiveAutoDelete, isActiveBackup];

  SweetPreferencesState copyWith({
    bool? firstTimeApp,
    bool? isActiveAutoDelete,
    bool? isDarkMode,
    bool? isActiveBackup,
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
      isActiveAutoDelete: isActiveAutoDelete ?? this.isActiveAutoDelete,
      themeColors: themeColors ?? this.themeColors,
      isActiveBackup: isActiveBackup ?? this.isActiveBackup,
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
