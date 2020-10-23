import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/helpers/Token.dart';
import 'package:testExample1/src/models/Token.dart';

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationRequested) {
      try {
        // Check has login
        if (await hasToken()) {
          Token token = Token(accessToken: await getToken());

          yield AuthenticationAuthenticated(token: token);
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (error) {
        yield AuthenticationUnauthenticated();
      }
    }
  }
}
