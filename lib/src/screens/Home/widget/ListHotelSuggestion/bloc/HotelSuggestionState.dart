import 'package:equatable/equatable.dart';
import 'package:testExample1/src/models/Hotel.dart';

abstract class HotelSuggestionState extends Equatable {
  const HotelSuggestionState();

  @override
  List<Object> get props => [];
}

class HotelSuggestionInitial extends HotelSuggestionState {}

class HotelSuggestionLoading extends HotelSuggestionState {}

class HotelSuggestionSuccess extends HotelSuggestionState {
  final List<Hotel> hotelSuggestion;

  HotelSuggestionSuccess({this.hotelSuggestion});

  @override
  List<Object> get props => [hotelSuggestion];

  @override
  String toString() => 'hotelSuggestion: $hotelSuggestion';
}

class HotelSuggestionFailure extends HotelSuggestionState {
  final String error;

  HotelSuggestionFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
