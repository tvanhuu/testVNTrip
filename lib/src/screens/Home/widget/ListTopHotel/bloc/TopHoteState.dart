import 'package:equatable/equatable.dart';
import 'package:testExample1/src/models/Hotel.dart';

abstract class TopHoteState extends Equatable {
  const TopHoteState();

  @override
  List<Object> get props => [];
}

class TopHoteInitial extends TopHoteState {}

class TopHoteLoading extends TopHoteState {}

class TopHoteSuccess extends TopHoteState {
  final List<Hotel> topHotel;

  TopHoteSuccess({this.topHotel});

  @override
  List<Object> get props => [topHotel];

  @override
  String toString() => 'topHotel: $topHotel';
}

class TopHoteFailure extends TopHoteState {
  final String error;

  TopHoteFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
