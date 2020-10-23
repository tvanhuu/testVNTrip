import 'package:equatable/equatable.dart';

abstract class TEMState extends Equatable {
  const TEMState();

  @override
  List<Object> get props => [];
}

class TEMInitial extends TEMState {}

class TEMLoading extends TEMState {}

class TEMSuccess extends TEMState {
  final List<dynamic> data;

  TEMSuccess({this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'data: $data';
}

class TEMFailure extends TEMState {
  final String error;

  TEMFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
