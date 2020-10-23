import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

int distanceInMeters(String endLatitude, String endLongitude) {
  double between = Geolocator.distanceBetween(
    21.003067016601562,
    105.7449690914168,
    double.parse(endLatitude),
    double.parse(endLongitude),
  );

  return (between / 1000).round();
}
