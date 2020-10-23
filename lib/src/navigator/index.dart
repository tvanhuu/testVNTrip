import 'package:flutter/material.dart';
import 'package:testExample1/src/screens/index.dart';

import '../app.dart';
import 'Router.dart';

Map<String, WidgetBuilder> routes(BuildContext context) {
  return {
    app: (BuildContext context) => App(),
    login: (BuildContext context) => Login(),
    map: (BuildContext context) => MapHotel(),
  };
}
