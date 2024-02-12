// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

/// Represents the state of Register in the application.
class RegisterState extends Equatable {
  RegisterState({
    this.edittextController,
    this.emailController,
    this.passwordController,
  });

  TextEditingController? edittextController;

  TextEditingController? emailController;

  TextEditingController? passwordController;

  @override
  List<Object?> get props => [
        edittextController,
        emailController,
        passwordController,
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
    );
  }
}
