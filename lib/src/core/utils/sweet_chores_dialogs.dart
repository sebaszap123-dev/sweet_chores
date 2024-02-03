import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

abstract class SweetDialogs {
  static BuildContext? context = getIt<SweetRouterCubit>().getContext();
  static unhandleErros({String? error}) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Oops... An Error Occurred',
        confirmButtonText: 'Okay',
        text:
            'We encountered an error while processing your request:\n$error\nPlease try again later or contact support for assistance.',
        onConfirm: () {
          getIt<SweetRouterCubit>().goHome();
          // ? TODO: Handle error and send to a logger in backend
          // print('sending exception $error to backend');
        },
      ),
    );
  }

  static databaseSqlite({String? error}) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Uh-oh! Cinnamon Needs a Break',
        confirmButtonText: 'Okay',
        text:
            'Oopsie-doodle! Our sweet cinnamon roll is taking a break and having a bit of trouble with some tasks $error. Thanks for your patience!',
        onConfirm: () {
          getIt<SweetRouterCubit>().goHome();
          // ? TODO: Handle error and send to a logger in backend
          // print('sending exception $error to backend');
        },
      ),
    );
  }

  static databaseToFirebaseBackup({String? error}) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Uh-oh! Cinnamon Needs a Break',
        confirmButtonText: 'Okay',
        text:
            'Oopsie-doodle! Our sweet cinnamon roll is taking a break and having a bit of trouble with some tasks $error. Thanks for your patience!',
        onConfirm: () async {
          await SweetSecurePreferences.rollbackOnErrorBackup();
        },
      ),
    );
  }

  static Future<bool> backupRequired() async {
    final nextDate = await SweetSecurePreferences.nextBackupDate;
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        customColumns: [
          Column(
            children: [
              Text(
                nextDate == null
                    ? 'Yuju! You want to activate you backup'
                    : 'Hey you already have a backup made. You need to wait till ${nextDate.toIso8601String()}',
                textAlign: TextAlign.justify,
                style: Theme.of(context!)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context!).colorScheme.tertiary),
              ),
              Positioned(
                child: Image.asset(
                  width: 200,
                  height: 200,
                  ImageConstant.noTasks,
                ),
              ),
              if (nextDate == null)
                const Text(
                  "Activate cloud backup for instant and monthly backups. This minimizes app disruptions and ensures an ad-free basic version. Your understanding is appreciated; we prioritize your experience!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black),
                ),
              const SizedBox(height: 10)
            ],
          ),
        ],
        confirmButtonText: nextDate == null ? 'Confirm' : 'Okay :c',
        showCancelBtn: nextDate == null,
      ),
    );
    if (resp != null &&
        resp.isTapConfirmButton &&
        nextDate != null &&
        nextDate.isBefore(DateTime.timestamp())) {
      await SweetSecurePreferences.updateBackupDate(
          date: DateTime.timestamp().toIso8601String());
      return true;
    }
    return false;
  }
}
