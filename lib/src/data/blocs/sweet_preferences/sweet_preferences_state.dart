part of 'sweet_preferences_bloc.dart';

class SweetPreferencesState extends Equatable {
  /// Now if user use the app if not show started route
  final bool firstTimeApp;

  /// User wants to autodelete chores when done
  final bool isActiveAutoDelete;

  /// Theme mode
  final bool isDarkMode;

  /// Delete days
  final int deleteDays;
  final ThemeData themeData;
  final SweetThemeColors themeColors;
  final SweetTheme typeTheme;
  final SweetChoresStatus status;

  const SweetPreferencesState({
    required this.themeColors,
    this.firstTimeApp = true,
    this.isActiveAutoDelete = false,
    this.isDarkMode = false,
    this.deleteDays = 7,
    this.typeTheme = SweetTheme.cinnamon,
    required this.themeData,
    this.status = SweetChoresStatus.initial,
  });
  @override
  List<Object> get props =>
      [firstTimeApp, themeData, isDarkMode, isActiveAutoDelete];

  SweetPreferencesState copyWith({
    bool? firstTimeApp,
    bool? isActiveAutoDelete,
    bool? isDarkMode,
    ThemeData? themeData,
    SweetChoresStatus? status,
    int? deleteDays,
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
      deleteDays: deleteDays ?? this.deleteDays,
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
