part of 'firebase_auth_bloc.dart';

sealed class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object> get props => [];
}

final class FirebaseInitial extends FirebaseState {}

final class FirebaseAuthState extends FirebaseState {
  final User userFirebase;
  final bool premium;
  const FirebaseAuthState({required this.userFirebase, this.premium = false});
}
