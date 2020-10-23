import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapRequested extends MapEvent {
  MapRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}
