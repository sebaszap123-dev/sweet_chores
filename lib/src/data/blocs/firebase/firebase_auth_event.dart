part of 'firebase_auth_bloc.dart';

sealed class FirebaseAuthEvent extends Equatable {
  const FirebaseAuthEvent();

  @override
  List<Object> get props => [];
}

class NoAccountLoginEvent extends FirebaseAuthEvent {}

class NoPremiumEvent extends FirebaseAuthEvent {
  const NoPremiumEvent(this.user);

  final User user;
}

class PremiumEvent extends FirebaseAuthEvent {
  const PremiumEvent(this.user);

  final User user;
  // TODO: GET PREMIUM DATA?
}
