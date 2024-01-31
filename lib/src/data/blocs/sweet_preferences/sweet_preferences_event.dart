part of 'sweet_preferences_bloc.dart';

enum SweetChoresStatus { initial, loading, success, error, theme }

class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];
}

class InitalStatusSweetCh extends PreferencesEvent {
  final SweetChoresStatus status;
  const InitalStatusSweetCh({this.status = SweetChoresStatus.initial});

  @override
  List<Object> get props => [status];
}

class ChangeThemeEvent extends PreferencesEvent {
  final SweetTheme theme;
  const ChangeThemeEvent({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}

class ChangeDarkModeEvent extends PreferencesEvent {
  final bool isDarkMode;
  const ChangeDarkModeEvent({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class ChangeBackupEvent extends PreferencesEvent {
  final bool isBackup;
  final String date;
  const ChangeBackupEvent({required this.isBackup, required this.date});

  @override
  List<Object> get props => [isBackup];
}

class ChangeDeleteStatusEvent extends PreferencesEvent {
  final bool autoDeleTask;
  final int time;
  const ChangeDeleteStatusEvent(
      {required this.autoDeleTask, required this.time});

  @override
  List<Object> get props => [autoDeleTask, time];
}
