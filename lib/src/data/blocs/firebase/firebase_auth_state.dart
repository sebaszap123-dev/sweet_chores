part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthState extends Equatable {
  const FirebaseAuthState({this.userFirebase});
  final User? userFirebase;
  @override
  List<Object> get props => [];
}

final class FirebaseAuthInitial extends FirebaseAuthState {}

final class FirebaseAuthNoAccount extends FirebaseAuthState {}

class FirebaseAuthPremium extends FirebaseAuthState {
  const FirebaseAuthPremium({required User userFirebase})
      : super(userFirebase: userFirebase);
}
