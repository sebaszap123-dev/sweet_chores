// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Register widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class RegisterEvent extends Equatable {}

/// Event that is dispatched when the Register widget is first created.
class RegisterInitialEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
