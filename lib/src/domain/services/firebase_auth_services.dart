import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sweet_chores_reloaded/src/core/utils/sweet_chores_dialogs.dart';

abstract class FirebaseAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

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

        return userCredential.user != null;
      } else {
        return false;
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
      return false;
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }
}
