import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

part 'sweet_preferences_event.dart';
part 'sweet_preferences_state.dart';

class SweetPreferencesBloc
    extends Bloc<PreferencesEvent, SweetPreferencesState> {
  SweetPreferencesBloc()
      : super(SweetPreferencesState(
            theme: SweetThemes.sweetboy(),
            typeTheme: SweetChoresThemes.sweetboy)) {
    on<InitalStatusSweetCh>(_initialState);
    on<ChangeTheme>(_onUpdateTheme);
    on<DarkMode>(_onDarkMode);
    on<AutoDeleteTask>(_onUpdateAutoDeleteTask);
  }

  void _initialState(
      InitalStatusSweetCh event, Emitter<SweetPreferencesState> emit) async {
    emit(state.copyWith(
      status: SweetChoresStatus.loading,
    ));
    final theme = await state.storageData.getThemeData;
    final firstOpen = await state.storageData.isFirstOpen;
    final isDarkMode = await state.storageData.isDarkMode;
    final autoTask = await state.storageData.autoDeleteTask;
    emit(state.copyWith(
      theme: theme['themeData'],
      typeTheme: theme['theme'],
      isDarkMode: isDarkMode,
      firstTimeApp: firstOpen,
      autoDeleteTask: autoTask,
      status: SweetChoresStatus.success,
    ));
  }

  void _onUpdateTheme(
      ChangeTheme event, Emitter<SweetPreferencesState> emit) async {
    final theme =
        SweetThemes.themeByType(event.theme, darkMode: state.isDarkMode);
    emit(state.copyWith(
      theme: theme,
      typeTheme: event.theme,
      status: SweetChoresStatus.success,
    ));
    await state.storageData.toggleTheme(event.theme);
  }

  void _onDarkMode(DarkMode event, Emitter<SweetPreferencesState> emit) async {
    ThemeData? updatedTheme;
    switch (state.typeTheme) {
      case SweetChoresThemes.sweetboy:
        updatedTheme = SweetThemes.sweetboy(darkMode: event.isDarkMode);
      case SweetChoresThemes.sweetgirl:
        updatedTheme = SweetThemes.sweetgirl(darkMode: event.isDarkMode);
    }
    emit(state.copyWith(
      theme: updatedTheme,
      isDarkMode: event.isDarkMode,
    ));
    await state.storageData.toggleDarkMode(event.isDarkMode);
  }

  void _onUpdateAutoDeleteTask(
      AutoDeleteTask event, Emitter<SweetPreferencesState> emit) async {
    emit(state.copyWith(autoDeleteTask: event.autoDeleTask));
    await state.storageData
        .toggleAutoDeleteTask(event.autoDeleTask, event.time);
  }
}
