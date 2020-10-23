import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationRequested extends AuthenticationEvent {
  AuthenticationRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'token';
}
