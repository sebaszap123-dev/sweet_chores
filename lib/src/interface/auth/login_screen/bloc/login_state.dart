// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

/// Represents the state of Login in the application.
class LoginState extends Equatable {
  LoginState({
    this.edittextController,
    this.passwordController,
    this.loginModelObj,
  });

  TextEditingController? edittextController;

  TextEditingController? passwordController;

  LoginModel? loginModelObj;

  @override
  List<Object?> get props => [
        edittextController,
        passwordController,
        loginModelObj,
      ];
  LoginState copyWith({
    TextEditingController? edittextController,
    TextEditingController? passwordController,
    LoginModel? loginModelObj,
  }) {
    return LoginState(
      edittextController: edittextController ?? this.edittextController,
      passwordController: passwordController ?? this.passwordController,
      loginModelObj: loginModelObj ?? this.loginModelObj,
    );
  }
}
