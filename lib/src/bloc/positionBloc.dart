import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testExample1/src/singleton/SingletonPosition.dart';

enum Event { Fetch, Success, Error }

class PositionBloc {
  PublishSubject _stateStreamController = PublishSubject<Event>();
  StreamSink<Event> get verSink => _stateStreamController.sink;
  Stream<Event> get verStream => _stateStreamController.stream;

  PositionBloc() {
    verStream.listen((event) async {
      if (event == Event.Fetch) {
        try {
          Position position = await Geolocator.getLastKnownPosition();
          print("position");
          print(position);
          SingletonPosition.getInstance(position: position);

          verSink.add(Event.Success);
        } catch (error) {
          verSink.addError(Event.Error);
          SingletonPosition.getInstance(
            position: new Position(
              latitude: 21.003067016601562,
              longitude: 105.7449690914168,
            ),
          );
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
