import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';

// Create storage

enum GlobalStatusApp { firstOpen, open }

class SweetChoresPreferences {
  final storage = FlutterSecureStorage(
      iOptions: getIOSOptions(), aOptions: getAndroidOptions());

  /// CONSTANT KEY theme
  final String themeKey = 'themeData';

  /// CONSTANT KEY status
  final String statusKey = 'sweet_preferences';

  /// CONSTANT KEY darkmode
  final String darkmodeKey = 'sweet_darkmode';

  /// CONSTANT KEY darkmode
  final String autoTaskKey = 'sweet_delete_notes';
  final String autoTime = 'sweet_delete_notes_time';

  final String initialStatus = GlobalStatusApp.firstOpen.name;
  static IOSOptions getIOSOptions() => const IOSOptions(
        accountName: AppleOptions.defaultAccountName,
      );
  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<bool> get isFirstOpen async {
    bool open = true;
    if (await storage.containsKey(key: statusKey)) {
      final readedValue = await storage.read(key: statusKey);
      open = readedValue == GlobalStatusApp.firstOpen.name;
    } else {
      await storage.write(key: statusKey, value: initialStatus);
    }
    return open;
  }

  Future<void> toggleDarkMode(bool value) async {
    await storage.write(key: darkmodeKey, value: value.toString());
  }

  Future<void> toggleAutoDeleteTask(bool value, int time) async {
    final now = DateTime.now();
    final timeLapse = now.add(Duration(days: time));
    await storage.write(key: autoTaskKey, value: value.toString());
    await storage.write(
        key: autoTime,
        value: value ? timeLapse.millisecondsSinceEpoch.toString() : null);
  }

  Future<void> toggleTheme(SweetChoresThemes value) async {
    await storage.write(key: themeKey, value: value.name);
  }

  Future<SweetChoresThemes> get getTheme async {
    final currentTheme = await storage.read(key: themeKey);
    late SweetChoresThemes theme;
    if (currentTheme != null) {
      theme = SweetChoresThemes.values.firstWhere(
        (theme) => theme.name == currentTheme,
        orElse: () => SweetChoresThemes.sweetboy,
      );
    } else {
      theme = SweetChoresThemes.sweetboy;
    }
    return theme;
  }

  Future<Map<String, dynamic>> get getThemeData async {
    SweetChoresThemes selectedTheme = SweetChoresThemes.sweetboy;
    bool isDarkMode = false;

    if (await storage.containsKey(key: themeKey)) {
      final readedTheme = await storage.read(key: themeKey);
      selectedTheme = SweetChoresThemes.values.firstWhere(
          (theme) => theme.name == readedTheme,
          orElse: () => SweetChoresThemes.sweetboy);
    } else {
      await storage.write(
          key: themeKey, value: SweetChoresThemes.sweetboy.name);
    }

    if (await storage.containsKey(key: darkmodeKey)) {
      final readedDarkMode = await storage.read(key: darkmodeKey);
      isDarkMode = readedDarkMode?.toLowerCase() == 'true';
    }

    return {
      'themeData': SweetThemes.themeByType(selectedTheme, darkMode: isDarkMode),
      'theme': selectedTheme
    };
  }

  Future<bool> get isDarkMode async {
    if (await storage.containsKey(key: darkmodeKey)) {
      final darkModeValue = await storage.read(key: darkmodeKey);
      return darkModeValue?.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  Future<bool> get autoDeleteTask async {
    if (await storage.containsKey(key: autoTaskKey)) {
      final autoValue = await storage.read(key: autoTaskKey);
      return autoValue?.toLowerCase() == 'true';
    } else {
      return false;
    }
  }

  Future<DateTime?> get getTimeTask async {
    final isActive = await autoDeleteTask;

    if (isActive) {
      if (await storage.containsKey(key: autoTime)) {
        final autoValue = await storage.read(key: autoTime);
        if (autoValue != null) {
          try {
            final timestamp = int.parse(autoValue);
            final dateTimeValue =
                DateTime.fromMillisecondsSinceEpoch(timestamp);
            return dateTimeValue;
          } catch (e) {
            throw Exception("Error parsing timestamp: $e");
          }
        }
      }
    }

    return null;
  }

  Future<void> initializedApp() async {
    await storage.write(key: statusKey, value: GlobalStatusApp.open.name);
  }
}
