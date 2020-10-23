import 'package:equatable/equatable.dart';
import 'package:testExample1/src/models/Token.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Token token;

  AuthenticationAuthenticated({this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'token: $token';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  AuthenticationUnauthenticated();

  @override
  List<Object> get props => [];
}
