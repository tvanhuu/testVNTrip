import 'package:geolocator/geolocator.dart';

class SingletonPosition {
  Position position;

  SingletonPosition({this.position});

  static SingletonPosition _instance;

  static SingletonPosition getInstance({position}) {
    if (position != null &&
        (_instance == null || _instance.position != position)) {
      _instance = SingletonPosition(position: position);
      return _instance;
    }
    return _instance;
  }
}

/**
 * Example
 * print(Token.getInstance(token: "token").token); // token
 */
