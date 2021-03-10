import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordDataEvent extends PasswordEvent {
  PasswordDataEvent({this.data});
  final String data;

  @override
  List<Object> get props => [data];
}

class PasswordResetEvent extends PasswordEvent {}
