import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';

abstract class SweetDialogs {
  static BuildContext? context = getIt<SweetRouterCubit>().getContext();
  static unhandledError({String? error}) {
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

  static void sendSupportEmail() async {
    final TextEditingController messageSupport = TextEditingController();
    final TextEditingController emailComunication = TextEditingController();
    await ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.info,
          title: 'Support center',
          customColumns: [
            const Text(
                'Please provide more information about yourself and an email address for communication.'),
            TextField(
              controller: emailComunication,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email for communication.',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.multiline,
              controller: messageSupport,
              decoration: const InputDecoration(
                labelText: 'Describe your situation',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
          ],
          onConfirm: () async {
            if (messageSupport.text.isNotEmpty &&
                emailComunication.text.isNotEmpty) {
              final Email email = Email(
                body: messageSupport.text,
                subject: 'EMAIL FORGOTTEN',
                recipients: ['sebaszap123@gmail.com'],
                cc: [emailComunication.text],
              );

              await FlutterEmailSender.send(email);
              getIt<SweetRouterCubit>().popDialogs();
            }
          }),
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
          Image.asset(
            width: 200,
            height: 200,
            ImageConstant.noTasks,
          ),
          if (nextDate == null)
            const Text(
              "Activate cloud backup for instant and monthly backups. This minimizes app disruptions and ensures an ad-free basic version. Your understanding is appreciated; we prioritize your experience!",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.black),
            ),
          const SizedBox(height: 10)
        ],
        confirmButtonText: nextDate == null ? 'Confirm' : 'Okay :c',
        showCancelBtn: nextDate == null,
      ),
    );
    final newDate = DateTime.now().add(const Duration(days: 30));
    if (resp != null &&
        resp.isTapConfirmButton &&
        nextDate != null &&
        nextDate.isBefore(DateTime.now())) {
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

  static Future<bool> showDeleteAccountAlert() async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'Are you sure you want to delete your account?',
        confirmButtonText: 'Yes, delete it',
        text:
            'This action cannot be undone. All your data will be permanently deleted.',
        showCancelBtn: true,
      ),
    );

    if (resp == null) {
      // Si el usuario cancela la acción o cierra la alerta, devuelve false
      return false;
    } else {
      // Si el usuario confirma la acción, devuelve true
      return resp.isTapConfirmButton;
    }
  }

  static Future<bool> showLogoutWarning() async {
    final ArtDialogResponse? resp = await ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: 'Logout Warning',
        confirmButtonText: 'Logout',
        cancelButtonText: 'Cancel',
        text:
            'Logging out will discard any unsaved chores in you drive backup. Are you sure you want to proceed?',
        showCancelBtn: true,
      ),
    );

    if (resp == null || !resp.isTapConfirmButton) {
      // El usuario cancela la acción o cierra la alerta
      return false;
    } else {
      // El usuario confirma la acción
      return true;
    }
  }
}
