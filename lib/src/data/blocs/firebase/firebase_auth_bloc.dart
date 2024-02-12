import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_chores/src/config/remote/drive_google_client.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/services/google_drive_service.dart';
import 'package:sweet_chores/src/domain/services/services.dart';

part 'firebase_auth_event.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseState> {
  FirebaseAuthBloc() : super(const FirebaseInitial()) {
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthLogOut>(_authLogoutEvent);
    on<AuthDeleteAccount>(_deleteAccoutEvent);
  }
  void _authLoginEvent(AuthLoginEvent event, Emitter<FirebaseState> emit) {
    if (state is FirebaseAuthState && event.isRouting) {
      return;
    } else {
      emit(FirebaseAuthState(
        userFirebase: event.user,
        premium: event.premium,
        isNew: event.isNew,
      ));
    }
  }

  void _authLogoutEvent(AuthLogOut event, Emitter<FirebaseState> emit) {
    emit(const FirebaseNoAuthState());
  }

  void _deleteAccoutEvent(
      AuthDeleteAccount event, Emitter<FirebaseState> emit) async {
    if (event.hasUser && event.deleteConfirmed) {
      if (state is FirebaseAuthState) {
        getIt<SweetRouterCubit>()
            .state
            .push(const AuthLayout(children: [DeleteAccountRoute()]));
        final currentState = state as FirebaseAuthState;
        final driveClient = await GoogleDriveService.loginGoogleDrive();
        if (driveClient != null) {
          await GoogleDriveService.deleteAllData(driveClient);
        }
        final deleted =
            await FirebaseAuthService.deleteAccount(currentState.userFirebase);
        if (deleted) {
          getIt<SweetRouterCubit>().deleteAccount();
        }
      }
      emit(const FirebaseNoAuthState());
    }
  }
}
