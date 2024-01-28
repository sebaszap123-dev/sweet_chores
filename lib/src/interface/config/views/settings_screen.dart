// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SweetChoresThemes? selectedOption = SweetChoresThemes.sweetboy;
  bool isDarkMode = false;
  bool autoDeleteTask = false;
  @override
  void initState() {
    isDarkMode = context.read<SweetPreferencesBloc>().state.isDarkMode;
    selectedOption = context.read<SweetPreferencesBloc>().state.typeTheme;
    autoDeleteTask = context.read<SweetPreferencesBloc>().state.autoDeleteTask;
    super.initState();
  }

  void _updateTheme(SweetChoresThemes? value) {
    final myTheme = value ?? SweetChoresThemes.sweetboy;
    final result = SweetChoresThemes.values.firstWhere(
      (theme) => theme == myTheme,
      orElse: () => SweetChoresThemes.sweetboy,
    );
    context.read<SweetPreferencesBloc>().add(ChangeTheme(theme: result));
    setState(() {
      selectedOption = value;
    });
  }

  void _updateDarkMode(bool value) async {
    setState(() {
      isDarkMode = value;
    });
    await Future.delayed(const Duration(milliseconds: 150));
    context.read<SweetPreferencesBloc>().add(DarkMode(isDarkMode: value));
  }

  void _updateAutoDeleteTask(bool value) async {
    setState(() {
      autoDeleteTask = value;
    });
    context
        .read<SweetPreferencesBloc>()
        .add(AutoDeleteTask(autoDeleTask: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => getIt<SweetRouterCubit>().state.pop(),
        ),
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark mode'),
              trailing: Switch(value: isDarkMode, onChanged: _updateDarkMode),
            ),
            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text('Auto-delete completed tasks'),
              trailing: Switch(
                value: autoDeleteTask,
                onChanged: _updateAutoDeleteTask,
              ),
            ),
            ListTile(
              enabled: autoDeleteTask,
              leading: const Icon(Icons.access_time),
              title: const Text('Cada:'),
              trailing: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: DropdownButton<int>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Theme.of(context).colorScheme.tertiary,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  value: 30,
                  underline: Container(),
                  items: [30, 60, 120]
                      .map((e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e días'),
                          ))
                      .toList(),
                  onChanged: autoDeleteTask ? (value) {} : null,
                ),
              ),
            ),
            Card(
              color: Theme.of(context).cardColor,
              shadowColor: Theme.of(context).colorScheme.tertiary,
              elevation: 2,
              child: Column(
                children: [
                  Text(
                    'My theme',
                    style: GoogleFonts.spicyRice(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                  _buildThemeOption(
                    Icons.person,
                    'Cinnamon',
                    SweetChoresThemes.sweetboy,
                  ),
                  _buildThemeOption(
                    Icons.person_outline,
                    'Strawberry',
                    SweetChoresThemes.sweetgirl,
                    color: Colors.pink.shade100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    IconData icon,
    String title,
    SweetChoresThemes value, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: Radio<SweetChoresThemes>(
        value: value,
        groupValue: selectedOption,
        onChanged: _updateTheme,
      ),
    );
  }
}
