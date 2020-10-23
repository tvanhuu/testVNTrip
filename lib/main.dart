import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/app.dart';
import 'package:testExample1/src/bloc/simple_bloc_delegate.dart';

import 'src/bloc/authentication/bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc()..add(AuthenticationRequested()),
        ),
      ],
      child: App(),
    ),
  );
}
