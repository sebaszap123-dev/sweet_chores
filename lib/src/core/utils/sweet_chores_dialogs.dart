import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';

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
          getIt<SweetRouterCubit>().popDialogs();
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

  static showPasswordResetSuccess() {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: 'Password Reset Successful!',
          confirmButtonText: 'Got it',
          text:
              'Your password has been reset successfully. You can now log in with your new password.',
          onConfirm: () {
            getIt<SweetRouterCubit>()
                .state
                .replace(const AuthLayout(children: [LoginRoute()]));
          }),
    );
  }

  static showRestoreResult({bool restoreSuccess = false}) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: restoreSuccess
            ? 'Yay! Restore Completed Successfully'
            : 'Oops! Cinnamon Needs a Break',
        confirmButtonText: restoreSuccess ? 'Gotcha' : 'OK',
        text: restoreSuccess
            ? 'Your sweet chores have been successfully restored!'
            : 'Oops! Something went wrong while restoring your sweet chores. Please try again in a few minutes.',
      ),
    );
  }

  static void alertInfo(
      {required String info, required String title, Function? onConfirm}) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.info,
          title: title,
          confirmButtonText: 'OK',
          text: info,
          onConfirm: onConfirm),
    );
  }

  static void deleteLastCategory() {
    String title = "Attention!";
    String info =
        "If you delete this category, you'll need to create a new one to add notes.";
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: title,
        confirmButtonText: 'OK',
        text: info,
      ),
    );
  }

  static Future<bool> wantRestoreFromBackup() async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.info,
        title: 'Do you want to restore from backup?',
        confirmButtonText: 'Yes',
        text:
            'You are going to restore a cloud backup you will miss your not saved data',
        showCancelBtn: true,
      ),
    );
    if (resp == null) {
      return false;
    } else {
      return resp.isTapConfirmButton;
    }
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
    final newDate = DateTime.timestamp().add(const Duration(days: 30));
    if (resp != null &&
        resp.isTapConfirmButton &&
        nextDate != null &&
        nextDate.isBefore(DateTime.timestamp())) {
      await SweetSecurePreferences.updateBackupDate(
          date: newDate.toIso8601String());
      return true;
    } else if (resp != null && nextDate == null && resp.isTapConfirmButton) {
      await SweetSecurePreferences.updateBackupDate(
          date: newDate.toIso8601String());
      return true;
    }
    return false;
  }
}
