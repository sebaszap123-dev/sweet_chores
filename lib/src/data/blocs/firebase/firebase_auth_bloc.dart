import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  FirebaseAuthBloc() : super(FirebaseAuthInitial()) {
    on<FirebaseAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
