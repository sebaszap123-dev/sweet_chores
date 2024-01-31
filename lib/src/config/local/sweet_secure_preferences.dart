import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/core/utils/sweet_chores_dialogs.dart';

// Create storage

enum GlobalStatusApp { firstOpen, open }

abstract class SweetSecurePreferences {
  static final _storage = FlutterSecureStorage(
      iOptions: _getIOSOptions, aOptions: _getAndroidOptions);

  /// CONSTANT KEY theme
  static const String _themeKey = 'themeData';

  /// CONSTANT KEY status
  static const String _statusKey = 'sweet_preferences';

  /// CONSTANT KEY darkmode
  static const String _darkmodeKey = 'sweet_darkmode';

  /// CONSTANT KEY autodeleteTask
  static const String _autoTaskKey = 'sweet_delete_notes';

  /// CONSTANT KEY autodeleteTask time
  static const String _autoTime = 'sweet_delete_notes_time';

  /// status if firstOpen or not
  static final String _initialStatus = GlobalStatusApp.firstOpen.name;

  /// Next backup date
  static const String _nextBackupDate = 'sweet_firebase_backup';
  static const String _activeBackup = 'sweet_firebase_backup_on';

  // ? GETTERS

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

  static Future<DateTime?> get nextBackupDate async {
    final date = await _storage.read(key: _nextBackupDate);
    if (date != null) {
      return DateTime.tryParse(date);
    }
    return null;
  }

  static Future<bool> get isActiveBackup async {
    final active = await _storage.read(key: _activeBackup);
    if (active != null) {
      return int.tryParse(active) == 1;
    }
    return false;
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

  static Future<SweetTheme> get getTheme async {
    final currentTheme = await _storage.read(key: _themeKey);
    if (currentTheme != null) {
      return SweetTheme.values.firstWhere(
        (theme) => theme.name == currentTheme,
        orElse: () {
          return SweetTheme.cinnamon;
        },
      );
    } else {
      return SweetTheme.cinnamon;
    }
  }

  static Future<bool> get isDarkMode async {
    final darkModeValue = await _storage.read(key: _darkmodeKey);
    if (darkModeValue != null) {
      return int.tryParse(darkModeValue) == 1;
    }
    return false;
  }

  static Future<bool> get isActiveAutoDelete async {
    final autoValue = await _storage.read(key: _autoTaskKey);
    if (autoValue != null) {
      return int.tryParse(autoValue) == 1;
    }
    return false;
  }

  static Future<DateTime?> get nextDeleteDate async {
    final isActive = await isActiveAutoDelete;

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

  // ? SETTERS

  static Future<void> toggleDarkMode(bool isDarkMode) async {
    await _storage.write(key: _darkmodeKey, value: isDarkMode ? '1' : '0');
  }

  static Future<void> changeBackupStatus(bool active, String date) async {
    final data = await _storage.read(key: _activeBackup);
    if (data != null && int.tryParse(data) == 1 && active) {
      return;
    } else if (active) {
      await _storage.write(key: _nextBackupDate, value: date);
    }
    await _storage.write(key: _activeBackup, value: active ? '1' : '0');
  }

  static Future<void> rollbackOnErrorBackup() async {
    await _storage.write(key: _nextBackupDate, value: null);
    await _storage.write(key: _activeBackup, value: null);
  }

  static Future<void> toggleAutoDeleteTask(bool isActive, int time) async {
    await _storage.write(key: _autoTaskKey, value: isActive ? '1' : '0');
    if (isActive) {
      final now = DateTime.now();
      final timeLapse = now.add(Duration(days: time));
      await _storage.write(key: _autoTime, value: timeLapse.toIso8601String());
    }
  }

  static Future<void> changeDateDeleteTasks(int time) async {
    final now = DateTime.now();
    final timeLapse = now.add(Duration(days: time));
    await _storage.write(key: _autoTime, value: timeLapse.toIso8601String());
  }

  static Future<void> toggleTheme(SweetTheme value) async {
    await _storage.write(key: _themeKey, value: value.name);
  }

  static Future<void> initializedApp() async {
    await _storage.write(key: _statusKey, value: GlobalStatusApp.open.name);
  }
}
