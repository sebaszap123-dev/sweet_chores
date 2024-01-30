import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  FirebaseAuthBloc() : super(FirebaseAuthInitial()) {
    on<NoAccountLoginEvent>(_noAccountLogin);
    on<NoPremiumEvent>(_noPremiumLogin);
    on<PremiumEvent>(_premiumLogin);
  }
  void _noAccountLogin(_, Emitter<FirebaseAuthState> emit) {
    emit(FirebaseAuthNoAccount());
  }

  void _noPremiumLogin(NoPremiumEvent event, Emitter<FirebaseAuthState> emit) {
    emit(FirebaseAuthPremium(userFirebase: event.user));
  }

  void _premiumLogin(PremiumEvent event, Emitter<FirebaseAuthState> emit) {
    emit(FirebaseAuthPremium(userFirebase: event.user));
  }
}
