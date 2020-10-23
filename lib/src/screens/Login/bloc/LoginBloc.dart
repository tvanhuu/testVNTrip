import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/api/repo/HotelRepository.dart';
import 'package:testExample1/src/bloc/authentication/bloc.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  HotelRepository hotelRepository = HotelRepository();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.authenticationBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequested) {
      try {
        yield LoginLoading();

        await hotelRepository.login();

        authenticationBloc.add(AuthenticationRequested());
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.message);
      }
    }
  }
}
