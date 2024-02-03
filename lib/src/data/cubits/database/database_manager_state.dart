part of 'database_manager_cubit.dart';

enum DatabaseStatus { initial, ready, error, loading }

class DatabaseManagerState extends Equatable implements DatabaseNotes {
  final DatabaseStatus status;
  final Database db;
  const DatabaseManagerState({
    this.status = DatabaseStatus.initial,
    required this.db,
  });

  @override
  List<Object?> get props => [status, db];

  DatabaseManagerState copyWith(
      {Database? db, Future<Database>? initDatabase, DatabaseStatus? status}) {
    return DatabaseManagerState(
        db: db ?? this.db, status: status ?? this.status);
  }
}
