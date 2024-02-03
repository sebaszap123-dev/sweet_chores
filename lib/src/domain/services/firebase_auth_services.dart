import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/google_drive_service.dart';

abstract class FirebaseAuthService {
  static final _googleSignIn =
      GoogleSignIn.standard(scopes: [DriveApi.driveFileScope]);

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
            final client =
                await GoogleDriveClient.create(googleSignInAccount, token);
            GoogleDriveService.downloadBackup(client);
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

  // TODO: IMPLEMENT
  static Future<void> signInSilently() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signInSilently();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // final client = await GoogleDriveClient.create(
      //     googleSignInAccount, credential.accessToken);
      // GoogleDriveService.downloadBackup(client);
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
