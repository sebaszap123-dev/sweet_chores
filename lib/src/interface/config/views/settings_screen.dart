// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/core/utils/checker_wifi.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/blocs/blocs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/google_drive_service.dart';
import 'package:sweet_chores/src/interface/common/common.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SweetTheme selectedOption = SweetTheme.cinnamon;
  bool isDarkMode = false;
  bool isActiveAutoDelete = false;
  int currentDeleteDays = 7;
  bool uploadingBackup = false;
  GoogleDriveClient? driveClient;
  TextStyle get styleCardTitle {
    return GoogleFonts.roboto(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 20,
    );
  }

  @override
  void initState() {
    isDarkMode = context.read<SweetPreferencesBloc>().state.isDarkMode;
    selectedOption = context.read<SweetPreferencesBloc>().state.typeTheme;
    isActiveAutoDelete =
        context.read<SweetPreferencesBloc>().state.isActiveAutoDelete;
    currentDeleteDays = context.read<SweetPreferencesBloc>().state.deleteDays;
    super.initState();
  }

  Future<void> makeLogin() async {
    if (driveClient == null) {
      final login = await GoogleDriveService.loginGoogleDrive();
      setState(() {
        driveClient = login;
      });
    }
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
    if (context.read<SweetPreferencesBloc>().state.typeTheme ==
        SweetTheme.strawberry) {
      SweetDialogs.alertInfo(
          info: 'Straberry theme is not available in darkmode.',
          title: "I'm sorry!");
      return;
    }
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
    context.read<SweetPreferencesBloc>().add(
        ChangeDeleteStatusEvent(autoDeleTask: value, time: currentDeleteDays));
  }

  void _uploadBackup() async {
    final hasInternet = await checkInternetState(scaffoldKey, context);
    if (hasInternet) {
      final resp = await SweetDialogs.backupRequired();
      if (resp) {
        setState(() {
          uploadingBackup = true;
        });
        await makeLogin();
        await GoogleDriveService.uploadFiles(driveClient);
        setState(() {
          uploadingBackup = false;
        });
      }
    }
  }

  void _downloadBackup() async {
    final hasInternet = await checkInternetState(scaffoldKey, context);
    if (hasInternet) {
      final resp = await SweetDialogs.wantRestoreFromBackup();
      if (resp) {
        setState(() {
          uploadingBackup = true;
        });
        await makeLogin();
        final isRestored = await GoogleDriveService.downloadBackup(driveClient);
        setState(() {
          uploadingBackup = false;
        });
        if (isRestored != null) {
          SweetDialogs.showRestoreResult(restoreSuccess: isRestored);
        }
      }
    }
  }

  String _getDurationText(int days) {
    if (days == 7) {
      return '1 week';
    } else if (days == 14) {
      return '2 weeks';
    } else if (days == 30) {
      return '1 month';
    } else if (days == 60) {
      return '2 months';
    } else if (days == 120) {
      return '4 months';
    } else {
      // Si deseas manejar otros valores de días, puedes agregar lógica aquí
      return '$days days';
    }
  }

  @override
  void dispose() {
    isDarkMode = false;
    isActiveAutoDelete = false;
    currentDeleteDays = 7;
    uploadingBackup = false;
    driveClient = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          style: Theme.of(context).textTheme.displayLarge,
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
                          'Preferences',
                          style: styleCardTitle,
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
                              value: currentDeleteDays,
                              underline: Container(),
                              items: [7, 14, 30, 60, 120]
                                  .map((e) => DropdownMenuItem<int>(
                                        value: e,
                                        child: Text(_getDurationText(e)),
                                      ))
                                  .toList(),
                              onChanged: isActiveAutoDelete
                                  ? (value) async {
                                      if (value != null) {
                                        await SweetSecurePreferences
                                            .changeDateDeleteTasks(value);
                                        setState(() {
                                          currentDeleteDays = value;
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
                          'Themes',
                          style: styleCardTitle,
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
                          style: styleCardTitle,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.cloud_upload_outlined,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          title: const Text('Backup chores'),
                          trailing: TextButton(
                            onPressed: _uploadBackup,
                            child: const Text('Upload'),
                          ),
                        ),
                        ListTile(
                            leading: Icon(
                              Icons.cloud_download_outlined,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            title: const Text('Restore chores'),
                            trailing: TextButton(
                              onPressed: _downloadBackup,
                              child: const Text('Dowload'),
                            )),
                        if (uploadingBackup) const Loading()
                      ],
                    ),
                  ),
                  cardStyled(
                    child: Column(
                      children: [
                        Text(
                          'Danger Zone',
                          style: styleCardTitle.copyWith(
                              color: Colors.amberAccent.shade700),
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.delete_right_fill,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          title: const Text('Delete account'),
                          trailing: TextButton(
                            onPressed: () async {
                              final delete =
                                  await SweetDialogs.showDeleteAccountAlert();
                              final hasUser =
                                  FirebaseAuth.instance.currentUser != null;
                              getIt<FirebaseAuthBloc>().add(AuthDeleteAccount(
                                  hasUser: hasUser, deleteConfirmed: delete));
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.redAccent.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
