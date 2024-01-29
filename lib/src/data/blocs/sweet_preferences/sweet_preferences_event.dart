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

class ChangeTheme extends PreferencesEvent {
  final SweetTheme theme;
  const ChangeTheme({
    required this.theme,
  });

  @override
  List<Object> get props => [theme];
}

class DarkMode extends PreferencesEvent {
  final bool isDarkMode;
  const DarkMode({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class AutoDeleteTask extends PreferencesEvent {
  final bool autoDeleTask;
  final int time;
  const AutoDeleteTask({required this.autoDeleTask, this.time = 30});

  @override
  List<Object> get props => [autoDeleTask, time];
}
