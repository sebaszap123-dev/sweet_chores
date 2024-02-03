import 'dart:io' as io;
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:path_provider/path_provider.dart';

// Use the google apis
import 'package:googleapis/drive/v3.dart' as gdrive_api;
import 'package:googleapis_auth/googleapis_auth.dart' as g_auth;

import "package:http/http.dart" as http;
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';

// The saved file
const fileName = 'privateFile';
const fileMime = 'application/vnd.google-apps.document';

// The App's specific folder
const appDataFolderName = 'appDataFolder';
const folderMime = 'application/vnd.google-apps.folder';

// This is the Http client that carries the calles with the needed headers
class AuthClient extends http.BaseClient {
  final http.Client _baseClient;
  final Map<String, String> _headers;

  AuthClient(this._baseClient, this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _baseClient.send(request);
  }
}

class GoogleDriveClient {
  late String _accessToken;
  late GoogleSignInAccount _googleAccount;
  late gdrive_api.DriveApi _driveApi;

  GoogleDriveClient._create(
      GoogleSignInAccount googleAccount, String accessToken) {
    _googleAccount = googleAccount;
    _accessToken = accessToken;
  }

//   static Future updateDbToDrive(
//       Future jsonFileFuture, String jsonFileName) async {
//     gdrive_api.File file = gdrive_api.File.fromJson({"name": jsonFileName});
//     file.id = jsonFileName;
//     File jsonFile = await jsonFileFuture;
// //if it doesn't work catch the error on future
//     return (gdrive_api.files.update(file, jsonFileName,
//         uploadMedia:
//             gdrive_api.Media(jsonFile.openRead(), jsonFile.lengthSync())));
//   }

  static Future<GoogleDriveClient> create(
      GoogleSignInAccount googleAccount, String accessToken) async {
    var component = GoogleDriveClient._create(googleAccount, accessToken);
    await component._initGoogleDriveApi();
    return component;
  }

  // Attach the needed headers to the http client.
  // Initializes the DriveApi with the auth client
  Future<void> _initGoogleDriveApi() async {
    final g_auth.AccessCredentials credentials = g_auth.AccessCredentials(
      g_auth.AccessToken(
        'Bearer',
        _accessToken,
        DateTime.now().toUtc().add(const Duration(days: 365)),
      ),
      null, // We don't have a refreshToken at this example
      [gdrive_api.DriveApi.driveAppdataScope],
    );
    var client = g_auth.authenticatedClient(http.Client(), credentials);
    var localAuthHeaders = await _googleAccount.authHeaders;
    var headers = localAuthHeaders;
    var authClient = AuthClient(client, headers);
    _driveApi = gdrive_api.DriveApi(authClient);
  }

  // Download the wanted file to the device in the specified folder
  Future<String?> _downloadFileToDevice(String fileId) async {
    gdrive_api.Media? file = (await _driveApi.files
            .get(fileId, downloadOptions: gdrive_api.DownloadOptions.fullMedia))
        as gdrive_api.Media?;
    if (file != null) {
      final directory = await getApplicationDocumentsDirectory();
      final saveFile = io.File('${directory.path}/$fileName');
      final first = await file.stream.first;
      saveFile.writeAsBytes(first);
      return saveFile.readAsString();
    }
    return null;
  }

  // Gets the id of the file from Google Drive
  // If the file doesn't exist it returns null
  Future<String?> _getFileIdFromGoogleDrive(String fileName) async {
    gdrive_api.FileList found = await _driveApi.files.list(
      q: "name = '$fileName'",
    );
    final files = found.files;
    if (files == null) {
      return null;
    }

    if (files.isNotEmpty) {
      return files.first.id;
    }
    return null;
  }

  // Creates a file with the content, and uploads it to google drive
  Future<String?> _createFileOnGoogleDrive(String fileName,
      {String? mimeType,
      String? content,
      List<String> parents = const []}) async {
    gdrive_api.Media? media;

    // Checks if the file already exists on Google Drive.
    // If it does, we delete it here and create a new one.
    var currentFileId = await _getFileIdFromGoogleDrive(fileName);
    if (currentFileId != null) {
      await _driveApi.files.delete(currentFileId);
    }

    if (fileName == fileName && content != null) {
      final directory = await getApplicationDocumentsDirectory();
      var created = io.File("${directory.path}/$fileName");
      created.writeAsString(content);
      var bytes = await created.readAsBytes();
      media = gdrive_api.Media(created.openRead(), bytes.lengthInBytes);
    }

    gdrive_api.File file = gdrive_api.File();
    file.name = fileName;
    file.mimeType = mimeType;
    file.parents = parents;

    // The acual file creation on Google Drive
    final fileCreation = await _driveApi.files.create(file, uploadMedia: media);
    if (fileCreation.id == null) {
      throw PlatformException(
        code: 'Error remoteStorageException',
        message: 'unable to create file on Google Drive',
      );
    }

    print("Created File ID: ${fileCreation.id} on RemoteStorage");
    return fileCreation.id!;
  }

  // Public client API:
  Future<void> uploadFile(String fileContent) async {
    try {
      String? folderId = await _createFileOnGoogleDrive(appDataFolderName,
          mimeType: folderMime);
      if (folderId != null) {
        await _createFileOnGoogleDrive(fileName,
            content: fileContent, parents: [folderId]);
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  Future<String?> downloadFile() async {
    try {
      var fileId = await _getFileIdFromGoogleDrive(fileName);

      if (fileId != null) {
        final fileContent = await _downloadFileToDevice(fileId);
        return fileContent;
      }
      SweetDialogs.unhandleErros(error: "File not found on storage");

      return null;
    } catch (e) {
      SweetDialogs.unhandleErros(error: "$e");
      return null;
    }
  }
}
