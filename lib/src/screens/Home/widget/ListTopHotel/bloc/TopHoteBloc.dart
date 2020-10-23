import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/api/repo/HotelRepository.dart';
import 'package:testExample1/src/models/Hotel.dart';

import 'bloc.dart';

class TopHoteBloc extends Bloc<TopHoteEvent, TopHoteState> {
  HotelRepository hotelRepository = HotelRepository();

  TopHoteBloc() : super(TopHoteInitial());

  @override
  Stream<TopHoteState> mapEventToState(TopHoteEvent event) async* {
    if (event is TopHoteRequested) {
      try {
        yield TopHoteLoading();

        List<Hotel> data =
            await hotelRepository.getHotelByField(field: "list-top-hotels/v2");

        yield TopHoteSuccess(topHotel: data);
      } catch (error) {
        yield TopHoteFailure(error: error.message);
      }
    }
  }
}
