import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:sweet_chores/src/config/local/database_notes.dart';
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/services.dart';

abstract class GoogleDriveService {
  static final _googleSignIn =
      GoogleSignIn.standard(scopes: [DriveApi.driveFileScope]);
  static Future<GoogleDriveClient?> loginGoogleDrive() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final token = googleSignInAuthentication?.accessToken;
      if (googleSignInAccount != null &&
          googleSignInAuthentication != null &&
          token != null) {
        return await GoogleDriveClient.create(googleSignInAccount, token);
      } else {
        SweetDialogs.unhandleErros(
            error: "ups can't connect to your google drive account");
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
    return null;
  }

  static Future<void> uploadFiles(GoogleDriveClient? client) async {
    try {
      // TODO: ACTIVAR EL BACKUPREQUIRED
      if (client != null) {
        // final resp = await SweetDialogs.backupRequired();
        final todos = await TodoHelper().getAllTodos();
        final ca = await CategoriesService().getAllCategory();
        final rawJson = todos.map((e) => e.toRawJson()).toList().toString();
        final rawCategories = ca.map((e) => e.toRawJson()).toList().toString();
        final Map<String, String> map = {
          DatabaseNotes.tbNotes: rawJson,
          DatabaseNotes.tbCategories: rawCategories
        };
        final dbBackup = json.encode(map);
        await client.uploadFile(dbBackup);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> downloadBackup(GoogleDriveClient? driveClient) async {
    if (driveClient != null) {
      final file = await driveClient.downloadFile();
      if (file != null) {
        try {
          // Decodificar la cadena JSON a una lista de mapas
          return getIt<DatabaseManagerCubit>().restoreBackup(file);
        } catch (e) {
          SweetDialogs.unhandleErros(error: e.toString());
          return false;
        }
      }
    }
    return false;
  }
}
