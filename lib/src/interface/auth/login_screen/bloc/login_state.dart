// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Represents the state of Login in the application.
class LoginState extends Equatable {
  LoginState({
    this.editEmailController,
    this.passwordController,
  });

  TextEditingController? editEmailController;

  TextEditingController? passwordController;

  @override
  List<Object?> get props => [
        editEmailController,
        passwordController,
      ];
  LoginState copyWith({
    TextEditingController? editEmailController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      editEmailController: editEmailController ?? this.editEmailController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}
