part of 'firebase_auth_bloc.dart';

enum FirebaseStatus { initial, success, loading }

abstract class FirebaseState extends Equatable {
  const FirebaseState(this.status);
  final FirebaseStatus status;

  @override
  List<Object?> get props => [status];
}

class FirebaseInitial extends FirebaseState {
  const FirebaseInitial() : super(FirebaseStatus.initial);
}

class FirebaseNoAuthState extends FirebaseState {
  const FirebaseNoAuthState() : super(FirebaseStatus.success);
}

class FirebaseAuthState extends FirebaseState {
  final User userFirebase;
  final bool premium;
  final GoogleDriveClient? clientDrive;

  const FirebaseAuthState({
    required this.userFirebase,
    this.premium = false,
    this.clientDrive,
    FirebaseStatus status = FirebaseStatus
        .success, // Puedes establecer un valor predeterminado aquí
  }) : super(status);

  FirebaseAuthState copyWith({
    User? userFirebase,
    bool? premium,
    GoogleDriveClient? clientDrive,
    FirebaseStatus? status,
  }) {
    return FirebaseAuthState(
      userFirebase: userFirebase ?? this.userFirebase,
      premium: premium ?? this.premium,
      clientDrive: clientDrive ?? this.clientDrive,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [userFirebase, premium, clientDrive, status];
}
