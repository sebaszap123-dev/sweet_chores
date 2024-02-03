import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';

part 'sweet_preferences_event.dart';
part 'sweet_preferences_state.dart';

class SweetPreferencesBloc
    extends Bloc<PreferencesEvent, SweetPreferencesState> {
  SweetPreferencesBloc() : super(SweetPreferencesState.instance) {
    on<InitalStatusSweetCh>(_initialState);
    on<ChangeThemeEvent>(_onUpdateTheme);
    on<ChangeDarkModeEvent>(_onDarkMode);
    on<ChangeDeleteStatusEvent>(_onUpdateAutoDeleteTask);
  }

  void _initialState(
      InitalStatusSweetCh event, Emitter<SweetPreferencesState> emit) async {
    emit(state.copyWith(
      status: SweetChoresStatus.loading,
    ));
    final theme = await SweetSecurePreferences.getTheme;
    final firstOpen = await SweetSecurePreferences.isFirstOpen;
    final isDarkMode = await SweetSecurePreferences.isDarkMode;
    final autoTask = await SweetSecurePreferences.isActiveAutoDelete;
    final themeColors = SweetThemeColors.fromMode(
        isDarkMode ? SweetMode.dark : SweetMode.light, theme);
    final themeData = SweetThemes.sweetThemeData(themeColors: themeColors);
    emit(state.copyWith(
      themeData: themeData,
      typeTheme: theme,
      isDarkMode: isDarkMode,
      firstTimeApp: firstOpen,
      isActiveAutoDelete: autoTask,
      themeColors: themeColors,
      status: SweetChoresStatus.success,
    ));
  }

  void _onUpdateTheme(
      ChangeThemeEvent event, Emitter<SweetPreferencesState> emit) async {
    final colors = SweetThemeColors.fromMode(
        state.isDarkMode ? SweetMode.dark : SweetMode.light, event.theme);
    final theme = SweetThemes.sweetThemeData(themeColors: colors);
    await SweetSecurePreferences.toggleTheme(event.theme);
    emit(state.copyWith(
      themeData: theme,
      typeTheme: event.theme,
      status: SweetChoresStatus.success,
    ));
  }

  void _onDarkMode(
      ChangeDarkModeEvent event, Emitter<SweetPreferencesState> emit) async {
    final colors = SweetThemeColors.fromMode(
        event.isDarkMode ? SweetMode.dark : SweetMode.light, state.typeTheme);
    final theme = SweetThemes.sweetThemeData(themeColors: colors);
    await SweetSecurePreferences.toggleDarkMode(event.isDarkMode);
    emit(state.copyWith(
      themeData: theme,
      themeColors: colors,
      isDarkMode: event.isDarkMode,
    ));
  }

  void _onUpdateAutoDeleteTask(ChangeDeleteStatusEvent event,
      Emitter<SweetPreferencesState> emit) async {
    emit(state.copyWith(isActiveAutoDelete: event.autoDeleTask));
    await SweetSecurePreferences.toggleAutoDeleteTask(
        event.autoDeleTask, event.time);
  }
}
