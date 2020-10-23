import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/api/repo/HotelRepository.dart';
import 'package:testExample1/src/models/Hotel.dart';

import 'bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  HotelRepository hotelRepository = HotelRepository();

  MapBloc() : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is MapRequested) {
      try {
        List<Hotel> hotels = await hotelRepository.searchHotel();

        yield MapSuccess(hotels: hotels);
      } catch (error) {
        yield MapFailure(error: error.message);
      }
    }
  }
}
