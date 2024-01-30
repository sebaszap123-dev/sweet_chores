import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/core/utils/sweet_chores_dialogs.dart';

// Create storage

enum GlobalStatusApp { firstOpen, open }

abstract class SweetChoresPreferences {
  static final _storage = FlutterSecureStorage(
      iOptions: _getIOSOptions, aOptions: _getAndroidOptions);

  /// CONSTANT KEY theme
  static const String _themeKey = 'themeData';

  /// CONSTANT KEY status
  static const String _statusKey = 'sweet_preferences';

  /// CONSTANT KEY darkmode
  static const String _darkmodeKey = 'sweet_darkmode';

  /// CONSTANT KEY darkmode
  static const String _autoTaskKey = 'sweet_delete_notes';
  static const String _autoTime = 'sweet_delete_notes_time';

  static final String _initialStatus = GlobalStatusApp.firstOpen.name;

  static IOSOptions get _getIOSOptions {
    return const IOSOptions(
      accountName: AppleOptions.defaultAccountName,
    );
  }

  static AndroidOptions get _getAndroidOptions {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  static Future<bool> get isFirstOpen async {
    bool open = true;
    if (await _storage.containsKey(key: _statusKey)) {
      final readedValue = await _storage.read(key: _statusKey);
      open = readedValue == GlobalStatusApp.firstOpen.name;
    } else {
      await _storage.write(key: _statusKey, value: _initialStatus);
    }
    return open;
  }

  static Future<void> toggleDarkMode(bool value) async {
    await _storage.write(key: _darkmodeKey, value: value.toString());
  }

  static Future<void> toggleAutoDeleteTask(bool value, int time) async {
    final now = DateTime.now();
    final timeLapse = now.add(Duration(days: time));
    await _storage.write(key: _autoTaskKey, value: value.toString());
    await _storage.write(
        key: _autoTime,
        value: value ? timeLapse.millisecondsSinceEpoch.toString() : null);
  }

  static Future<void> toggleTheme(SweetTheme value) async {
    await _storage.write(key: _themeKey, value: value.name);
  }

  static Future<SweetTheme> get getTheme async {
    final currentTheme = await _storage.read(key: _themeKey);
    bool orElse = false;
    if (currentTheme != null) {
      final theme = SweetTheme.values.firstWhere(
        (theme) => theme.name == currentTheme,
        orElse: () {
          orElse = true;
          return SweetTheme.cinnamon;
        },
      );
      if (orElse) {
        await _storage.write(key: _themeKey, value: SweetTheme.cinnamon.name);
      }
      return theme;
    } else {
      await _storage.write(key: _themeKey, value: SweetTheme.cinnamon.name);
      return SweetTheme.cinnamon;
    }
  }

  static Future<bool> get isDarkMode async {
    if (await _storage.containsKey(key: _darkmodeKey)) {
      final darkModeValue = await _storage.read(key: _darkmodeKey);
      return darkModeValue?.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  static Future<bool> get autoDeleteTask async {
    if (await _storage.containsKey(key: _autoTaskKey)) {
      final autoValue = await _storage.read(key: _autoTaskKey);
      return autoValue?.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  static Future<DateTime?> get getTimeTask async {
    final isActive = await autoDeleteTask;

    if (isActive) {
      if (await _storage.containsKey(key: _autoTime)) {
        final autoValue = await _storage.read(key: _autoTime);
        if (autoValue != null) {
          try {
            final timestamp = int.parse(autoValue);
            final dateTimeValue =
                DateTime.fromMillisecondsSinceEpoch(timestamp);
            return dateTimeValue;
          } catch (e) {
            SweetDialogs.unhandleErros(error: '$e');
          }
        }
      }
    }

    return null;
  }

  static Future<void> initializedApp() async {
    await _storage.write(key: _statusKey, value: GlobalStatusApp.open.name);
  }
}
