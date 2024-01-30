part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends FirebaseAuthEvent {
  final User user;
  final bool premium;

  const AuthLoginEvent({required this.user, required this.premium});
}
