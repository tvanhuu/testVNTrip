import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class TEMBloc extends Bloc<TEMEvent, TEMState> {
  TEMBloc() : super(TEMInitial());

  @override
  Stream<TEMState> mapEventToState(TEMEvent event) async* {
    if (event is TEMRequested) {
      try {
        List<dynamic> data = [];

        yield TEMSuccess(data: data);
      } catch (error) {
        yield TEMFailure(error: error.message);
      }
    }
  }
}
