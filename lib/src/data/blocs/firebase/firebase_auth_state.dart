part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthState extends Equatable {
  const FirebaseAuthState();
  @override
  List<Object> get props => [];
}

final class FirebaseAuthInitial extends FirebaseAuthState {}

final class FirebaseAuthNoAccount extends FirebaseAuthState {}

class FirebaseAuthPremium extends FirebaseAuthState {
  final User userFirebase;
  const FirebaseAuthPremium({required this.userFirebase});
}
