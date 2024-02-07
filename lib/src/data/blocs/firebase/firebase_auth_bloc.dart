import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseState> {
  FirebaseAuthBloc() : super(FirebaseInitial()) {
    on<AuthLoginEvent>(_authLogin);
    on<AuthResetPassword>(_authResetPassword);
  }
  void _authLogin(AuthLoginEvent event, Emitter<FirebaseState> emit) {
    emit(FirebaseAuthState(userFirebase: event.user, premium: event.premium));
  }

  void _authResetPassword(
      AuthResetPassword event, Emitter<FirebaseState> emit) {
    if (state is FirebaseAuthState) {
      // TODO AUTH-reset-pw: DO THE RESET OF PASSWORD
    }
  }
}
