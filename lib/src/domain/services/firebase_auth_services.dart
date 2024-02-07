import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive3;
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/google_drive_service.dart';

abstract class FirebaseAuthService {
  static final _googleSignIn =
      GoogleSignIn.standard(scopes: [drive3.DriveApi.driveFileScope]);

  static Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final hasUser = userCredential.user != null;
        if (hasUser) {
          final token = googleSignInAuthentication.accessToken;
          if (token != null) {
            await Future.delayed(const Duration(milliseconds: 200));
            final client =
                await GoogleDriveClient.create(googleSignInAccount, token);
            final hasBackupFile =
                await GoogleDriveService.hasBackupFile(client);
            if (!hasBackupFile) {
              _extraActionsLogin();
              return true;
            }
            final resp = await SweetDialogs.wantRestoreFromBackup();
            if (resp) {
              GoogleDriveService.downloadBackup(client);
            } else {
              _extraActionsLogin();
            }
            return true;
          }
        }
        return userCredential.user != null;
      } else {
        return false;
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
      return false;
    }
  }

  static Future<void> _extraActionsLogin() async {
    await Future.delayed(const Duration(milliseconds: 300));
    getIt<DatabaseManagerCubit>().toDefaults();
  }

  // TODO AUTH-reset-pw: use for reset
  static Future<void> sendResetPassowrd({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'auth/invalid-email':
          SweetDialogs.alertInfo(
              info: 'The email address provided is not valid.',
              title: 'Invalid Email');
          break;
        case 'auth/missing-android-pkg-name':
          SweetDialogs.alertInfo(
              info: 'An Android package name must be provided.',
              title: 'Missing Android Package Name');
          break;
        case 'auth/missing-continue-uri':
          SweetDialogs.alertInfo(
              info: 'A continue URL must be provided.',
              title: 'Missing Continue URL');
          break;
        case 'auth/missing-ios-bundle-id':
          SweetDialogs.alertInfo(
              info: 'An iOS Bundle ID must be provided.',
              title: 'Missing iOS Bundle ID');
          break;
        case 'auth/invalid-continue-uri':
          SweetDialogs.alertInfo(
              info: 'The continue URL provided is invalid.',
              title: 'Invalid Continue URL');
          break;
        case 'auth/unauthorized-continue-uri':
          SweetDialogs.alertInfo(
              info:
                  'The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.',
              title: 'Unauthorized Continue URL');
          break;
        case 'auth/user-not-found':
          SweetDialogs.alertInfo(
              info: 'No user found for the provided email address.',
              title: 'User Not Found');
          break;
        default:
          // Manejar otros códigos de error aquí
          String errorMessage = e.message ?? 'Unknown Error';
          SweetDialogs.alertInfo(info: errorMessage, title: 'Error');
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: e.toString());
    }
  }

  // TODO AUTH-reset-pw: use for reset
  static Future<void> confirmPasswordReset(
      {required String code, required String password}) async {
    try {
      await FirebaseAuth.instance
          .confirmPasswordReset(code: code, newPassword: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'expired-action-code':
          SweetDialogs.alertInfo(
              info: 'The action code has expired.',
              title: 'Expired Action Code');
          break;
        case 'invalid-action-code':
          SweetDialogs.alertInfo(
              info: 'The action code is invalid.',
              title: 'Invalid Action Code');
          break;
        case 'user-disabled':
          SweetDialogs.alertInfo(
              info:
                  'The user associated with the action code has been disabled.',
              title: 'User Disabled');
          break;
        case 'user-not-found':
          SweetDialogs.alertInfo(
              info: 'No user found for the action code.',
              title: 'User Not Found');
          break;
        case 'weak-password':
          SweetDialogs.alertInfo(
              info: 'The new password is not strong enough.',
              title: 'Weak Password');
          break;
        default:
          // Manejar otros códigos de error aquí
          String errorMessage = e.message ?? 'Unknown Error';
          SweetDialogs.alertInfo(info: errorMessage, title: 'Error');
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: e.toString());
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      getIt<DatabaseManagerCubit>().onLogOut();
      await _googleSignIn.signOut();
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }
}
