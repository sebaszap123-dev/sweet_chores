import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_chores_reloaded/src/config/remote/drive_google_client.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseState> {
  FirebaseAuthBloc() : super(FirebaseInitial()) {
    on<AuthLoginEvent>(_authLogin);
  }
  void _authLogin(AuthLoginEvent event, Emitter<FirebaseState> emit) {
    emit(FirebaseAuthState(userFirebase: event.user, premium: event.premium));
  }
}
