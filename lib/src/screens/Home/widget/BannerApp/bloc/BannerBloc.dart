import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/api/repo/HotelRepository.dart';
import 'package:testExample1/src/models/BannerQuick.dart';

import 'bloc.dart';

class BanneBloc extends Bloc<BanneEvent, BanneState> {
  HotelRepository hotelService = HotelRepository();

  BanneBloc() : super(BanneInitial());

  @override
  Stream<BanneState> mapEventToState(BanneEvent event) async* {
    if (event is BanneRequested) {
      try {
        List<BannerQuick> data = await hotelService.getBanner();

        yield BanneSuccess(banners: data);
      } catch (error) {
        yield BanneFailure(error: error.message);
      }
    }
  }
}
