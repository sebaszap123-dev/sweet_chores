// TODO: IMPLEMENT DATABASE
import 'package:firebase_core/firebase_core.dart';
import 'package:sweet_chores_reloaded/firebase_options.dart';

class FirebaseDatabase {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
