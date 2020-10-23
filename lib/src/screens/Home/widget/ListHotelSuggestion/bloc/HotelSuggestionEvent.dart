import 'package:equatable/equatable.dart';

abstract class HotelSuggestionEvent extends Equatable {
  const HotelSuggestionEvent();

  @override
  List<Object> get props => [];
}

class HotelSuggestionRequested extends HotelSuggestionEvent {
  HotelSuggestionRequested();

  @override
  List<Object> get props => [];

  @override
  String toString() => '';
}
