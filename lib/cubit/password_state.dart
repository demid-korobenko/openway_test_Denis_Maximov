import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitialState extends PasswordState {}

class PasswordCodeState extends PasswordState {
  final String data;
  PasswordCodeState({this.data});
  @override
  List<Object> get props => [data];
}

class PasswordCorectState extends PasswordState {
  final bool passwordCorect;
  PasswordCorectState({this.passwordCorect});
  @override
  List<Object> get props => [passwordCorect];
}

class PasswordNoCorectState extends PasswordState {
  final bool passwordCorect;
  PasswordNoCorectState({this.passwordCorect});
  @override
  List<Object> get props => [passwordCorect];
}

class PasswordReset extends PasswordState {}

class PaswordDataState extends PasswordState {
  final String passwordUi;
  PaswordDataState({this.passwordUi});

  @override
  List<Object> get props => [passwordUi];
}

class PasswordHelper extends PasswordState {
  final String message;
  PasswordHelper({this.message});
  @override
  List<Object> get props => [message];
}
