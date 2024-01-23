// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

/// Represents the state of Register in the application.
class RegisterState extends Equatable {
  RegisterState({
    this.edittextController,
    this.emailController,
    this.passwordController,
    this.registerModelObj,
  });

  TextEditingController? edittextController;

  TextEditingController? emailController;

  TextEditingController? passwordController;

  RegisterModel? registerModelObj;

  @override
  List<Object?> get props => [
        edittextController,
        emailController,
        passwordController,
        registerModelObj,
      ];
  RegisterState copyWith({
    TextEditingController? edittextController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    RegisterModel? registerModelObj,
  }) {
    return RegisterState(
      edittextController: edittextController ?? this.edittextController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      registerModelObj: registerModelObj ?? this.registerModelObj,
    );
  }
}
