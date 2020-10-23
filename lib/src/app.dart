import 'package:flutter/material.dart';
import 'package:testExample1/src/screens/index.dart';

import 'bloc/positionBloc.dart';
import 'navigator/Main.dart';
import 'navigator/index.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PositionBloc _positionBloc;

  @override
  void initState() {
    super.initState();

    _positionBloc = PositionBloc();
    _positionBloc.verSink.add(Event.Fetch);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes(context),
      home: Scaffold(
        body: StreamBuilder<Object>(
          stream: _positionBloc.verStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) return Main();
            return Center(child: CircularProgressIndicator());
          },
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
