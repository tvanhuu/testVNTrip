import 'package:equatable/equatable.dart';

abstract class TopHoteEvent extends Equatable {
  const TopHoteEvent();

  @override
  List<Object> get props => [];
}

class TopHoteRequested extends TopHoteEvent {
  TopHoteRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}
