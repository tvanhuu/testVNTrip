import 'package:equatable/equatable.dart';

abstract class BanneEvent extends Equatable {
  const BanneEvent();

  @override
  List<Object> get props => [];
}

class BanneRequested extends BanneEvent {
  BanneRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}
