// ignore_for_file: must_be_immutable

part of 'forgot_password_bloc.dart';

/// Represents the state of ForgotPassword in the application.
class ForgotPasswordState extends Equatable {
  ForgotPasswordState({
    this.phoneNumberController,
    this.forgotPasswordModelObj,
  });

  TextEditingController? phoneNumberController;

  ForgotPasswordModel? forgotPasswordModelObj;

  @override
  List<Object?> get props => [
        phoneNumberController,
        forgotPasswordModelObj,
      ];
  ForgotPasswordState copyWith({
    TextEditingController? phoneNumberController,
    ForgotPasswordModel? forgotPasswordModelObj,
  }) {
    return ForgotPasswordState(
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      forgotPasswordModelObj:
          forgotPasswordModelObj ?? this.forgotPasswordModelObj,
    );
  }
}
