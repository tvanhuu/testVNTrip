import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("onEvent => {$event}, $bloc");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("onTransition => {$transition}, $bloc");
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print("onChange => {$change}, ${cubit.runtimeType}");
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print("onError => {$error} , $cubit");
    super.onError(cubit, error, stackTrace);
  }
}
