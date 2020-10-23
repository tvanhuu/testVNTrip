import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  LoginRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}
