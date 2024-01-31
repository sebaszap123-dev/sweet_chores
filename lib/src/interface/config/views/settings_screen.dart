// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores_reloaded/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/interface/common/common.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SweetTheme selectedOption = SweetTheme.cinnamon;
  bool isDarkMode = false;
  bool isActiveAutoDelete = false;
  bool backup = false;
  int defaultDays = 7;
  bool uploadingBackup = false;
  @override
  void initState() {
    isDarkMode = context.read<SweetPreferencesBloc>().state.isDarkMode;
    selectedOption = context.read<SweetPreferencesBloc>().state.typeTheme;
    isActiveAutoDelete =
        context.read<SweetPreferencesBloc>().state.isActiveAutoDelete;
    backup = context.read<SweetPreferencesBloc>().state.isActiveBackup;
    super.initState();
  }

  void _updateTheme(SweetTheme? value) {
    if (value != null) {
      final myTheme = value;
      final result = SweetTheme.values.firstWhere(
        (theme) => theme == myTheme,
        orElse: () => SweetTheme.cinnamon,
      );
      context.read<SweetPreferencesBloc>().add(ChangeThemeEvent(theme: result));
      setState(() {
        selectedOption = value;
      });
    }
  }

  void _updateDarkMode(bool value) async {
    context
        .read<SweetPreferencesBloc>()
        .add(ChangeDarkModeEvent(isDarkMode: value));
    setState(() {
      isDarkMode = value;
    });
  }

  void _updateAutoDeleteTask(bool value) async {
    setState(() {
      isActiveAutoDelete = value;
    });
    context
        .read<SweetPreferencesBloc>()
        .add(ChangeDeleteStatusEvent(autoDeleTask: value, time: defaultDays));
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
      body: BlocBuilder<FirebaseAuthBloc, FirebaseState>(
        builder: (context, state) {
          if (state is FirebaseAuthState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  cardStyled(
                    child: Column(
                      children: [
                        Text(
                          'Settings',
                          style: GoogleFonts.spicyRice(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text('Dark mode'),
                          trailing: Switch(
                              value: isDarkMode, onChanged: _updateDarkMode),
                        ),
                        ListTile(
                          leading: const Icon(Icons.notes),
                          title: const Text('Auto-delete completed tasks'),
                          trailing: Switch(
                            value: isActiveAutoDelete,
                            onChanged: _updateAutoDeleteTask,
                          ),
                        ),
                        ListTile(
                          enabled: isActiveAutoDelete,
                          leading: const Icon(Icons.access_time),
                          title: const Text('Each:'),
                          trailing: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            child: DropdownButton<int>(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              iconEnabledColor: Colors.white,
                              dropdownColor:
                                  Theme.of(context).colorScheme.tertiary,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              value: defaultDays,
                              underline: Container(),
                              items: [7, 14, 30, 60, 120]
                                  .map((e) => DropdownMenuItem<int>(
                                        value: e,
                                        // ? TODO: PARSE WEEK, MONTH string instead days
                                        child: Text('$e days'),
                                      ))
                                  .toList(),
                              onChanged: isActiveAutoDelete
                                  ? (value) async {
                                      if (value != null) {
                                        await SweetSecurePreferences
                                            .changeDateDeleteTasks(value);
                                        setState(() {
                                          defaultDays = defaultDays;
                                        });
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  cardStyled(
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
                          SweetTheme.cinnamon,
                        ),
                        _buildThemeOption(
                          Icons.person_outline,
                          'Strawberry',
                          SweetTheme.strawberry,
                          color: Colors.pink.shade100,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  cardStyled(
                    child: Column(
                      children: [
                        Text(
                          'Backup',
                          style: GoogleFonts.spicyRice(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.cloud_upload_outlined,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          title: const Text('Backup chores'),
                          trailing: Switch(
                              value: backup,
                              onChanged: (value) async {
                                if (value) {
                                  final resp =
                                      await SweetDialogs.backupRequired();
                                  setState(() {
                                    backup = resp;
                                    uploadingBackup = resp;
                                  });
                                  if (resp) {
                                    // TODO: IMPLEMENT ELSEWHERE
                                    // final now = DateTime.timestamp();
                                    // final date = now
                                    //     .add(const Duration(days: 30))
                                    //     .toIso8601String();
                                    // getIt<SweetPreferencesBloc>().add(
                                    //     ChangeBackupEvent(
                                    //         isBackup: resp, date: date));
                                    // final lastDate =
                                    //     await SweetSecurePreferences
                                    //         .nextBackupDate;
                                    // await DriveGoogleHelper.backupTodos(
                                    //   state.userFirebase.uid,
                                    //   lastDate?.toIso8601String(),
                                    //   date,
                                    // );
                                  }
                                  setState(() {
                                    uploadingBackup = false;
                                  });
                                } else {
                                  getIt<SweetPreferencesBloc>().add(
                                      const ChangeBackupEvent(
                                          isBackup: false, date: '--'));
                                  setState(() {
                                    backup = false;
                                  });
                                }
                              }),
                        ),
                        if (uploadingBackup) const Loading()
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget cardStyled({required Widget child}) {
    return Card(
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 2,
      child: child,
    );
  }

  Widget _buildThemeOption(
    IconData icon,
    String title,
    SweetTheme value, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: Radio<SweetTheme>(
        value: value,
        groupValue: selectedOption,
        onChanged: _updateTheme,
      ),
    );
  }
}
