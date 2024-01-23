// ignore_for_file: depend_on_referenced_packages

import 'package:share_extend/share_extend.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sweet_chores_reloaded/src/config/local/database_notes.dart';
import 'package:sweet_chores_reloaded/src/data/data_source.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

// ? TODO: HANDLE ERROS (implement dialogs global with sweet_alert and geit)
class DatabaseHelper {
  static Future<void> exportDatabase() async {
    final db = getIt<DatabaseManagerCubit>().database;
    try {
      final documentsDirectory = await getTemporaryDirectory();
      final backupPath = join(documentsDirectory.path,
          '${DateTime.now().toIso8601String()}_backup.db');

      await db.rawQuery('ATTACH DATABASE ? AS backupDB', [backupPath]);
      await db.rawQuery('SELECT * FROM main.sqlite_master', []);
      await db.rawQuery('DETACH DATABASE backupDB', []);
      await ShareExtend.share(backupPath, 'file');
    } catch (e) {
      // Maneja errores según sea necesario
    }
  }

  static Future<void> importDatabaseFromFilePicker() async {
    try {
      // Usar FilePicker para seleccionar un archivo
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        io.File fileToImport = io.File(file.path!);

        // Importar la base de datos desde el archivo seleccionado
        await importDatabaseFile(fileToImport);
      }
    } catch (e) {
      // SOMETHING Error selecting and importing database file
    }
  }

  static Future<void> importDatabaseFile(io.File dbToImport) async {
    final db = getIt<DatabaseManagerCubit>().database;
    try {
      // Cerrar la base de datos actual
      await _closeDatabase(db);

      // Eliminar la base de datos actual
      await _deleteCurrentDatabase();

      // Importar la base de datos desde el archivo
      await _importDatabase(dbToImport);
    } catch (e) {
      // SOMETHING
    }
  }

  static Future<void> _closeDatabase(Database db) async {
    if (db.isOpen) {
      await db.close();
    }
  }

  static Future<void> _deleteCurrentDatabase() async {
    final currentDatabasePath = await DatabaseNotes.getPath();
    final currentDatabaseFile = io.File(currentDatabasePath);
    if (await currentDatabaseFile.exists()) {
      await currentDatabaseFile.delete();
    }
  }

  static Future<void> _importDatabase(io.File dbToImport) async {
    final targetDatabasePath = await DatabaseNotes.getPath();
    final targetDatabaseFile = io.File(targetDatabasePath);

    // Leer contenido del archivo a importar
    List<int> content = await dbToImport.readAsBytes();

    // Escribir contenido en la nueva base de datos
    await targetDatabaseFile.writeAsBytes(content, flush: true);
  }
}
