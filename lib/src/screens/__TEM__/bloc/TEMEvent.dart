import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TEMEvent extends Equatable {
  const TEMEvent();

  @override
  List<Object> get props => [];
}

class TEMRequested extends TEMEvent {
  final String token;

  TEMRequested({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'token: $token';
}
