import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/api/repo/HotelRepository.dart';
import 'package:testExample1/src/models/Hotel.dart';

import 'bloc.dart';

class HotelSuggestionBloc
    extends Bloc<HotelSuggestionEvent, HotelSuggestionState> {
  HotelRepository hotelRepository = HotelRepository();

  HotelSuggestionBloc() : super(HotelSuggestionInitial());

  @override
  Stream<HotelSuggestionState> mapEventToState(
      HotelSuggestionEvent event) async* {
    if (event is HotelSuggestionRequested) {
      try {
        List<Hotel> hotelSuggestion =
            await hotelRepository.getHotelByField(field: "list-home-hotels/v3");

        yield HotelSuggestionSuccess(hotelSuggestion: hotelSuggestion);
      } catch (error) {
        yield HotelSuggestionFailure(error: error.message);
      }
    }
  }
}
