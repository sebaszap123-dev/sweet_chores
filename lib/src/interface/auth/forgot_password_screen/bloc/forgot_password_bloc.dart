import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/interface/auth/forgot_password_screen/models/forgot_password_model.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

/// A bloc that manages the state of a ForgotPassword according to the event that is dispatched to it.
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(ForgotPasswordState initialState) : super(initialState) {
    on<ForgotPasswordInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ForgotPasswordInitialEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(phoneNumberController: TextEditingController()));
  }
}
