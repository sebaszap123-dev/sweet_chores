part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends FirebaseAuthEvent {
  final User user;
  final bool premium;
  final bool isNew;
  final bool isRouting;
  const AuthLoginEvent(
      {required this.user,
      required this.premium,
      required this.isNew,
      this.isRouting = false});
}

class AuthLogOut extends FirebaseAuthEvent {}

class AuthDeleteAccount extends FirebaseAuthEvent {
  final bool hasUser;
  final bool deleteConfirmed;
  const AuthDeleteAccount(
      {required this.hasUser, required this.deleteConfirmed});
}
