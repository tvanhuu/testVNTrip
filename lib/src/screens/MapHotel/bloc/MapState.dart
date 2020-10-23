import 'package:equatable/equatable.dart';
import 'package:testExample1/src/models/Hotel.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapSuccess extends MapState {
  final List<Hotel> hotels;

  MapSuccess({this.hotels});

  @override
  List<Object> get props => [hotels];

  @override
  String toString() => 'hotels: $hotels';
}

class MapFailure extends MapState {
  final String error;

  MapFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
