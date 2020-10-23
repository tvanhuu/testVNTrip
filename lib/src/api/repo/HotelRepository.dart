import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testExample1/src/helpers/Token.dart';
import 'package:testExample1/src/models/BannerQuick.dart';
import 'package:testExample1/src/models/Hotel.dart';
import 'package:testExample1/src/models/Token.dart';
import 'package:testExample1/src/singleton/SingletonPosition.dart';

import '../request.dart';

abstract class HotelService {
  Future<List<Hotel>> getHotelByField();
  Future<List<BannerQuick>> getBanner();
  Future<Token> login();
  Future<List<Hotel>> searchHotel();
}

class HotelRepository extends HotelService {
  @override
  Future<List<Hotel>> getHotelByField({String field}) async {
    try {
      Position position = SingletonPosition.getInstance().position;

      Response response = await DioProvider.request().get(
        "$field?lat=${position.latitude}&lng=${position.longitude}",
      );

      if (response.data["data"] == null) {
        throw Exception("Error!");
      }

      List<Hotel> data = (response.data["data"] as List)
          .map((e) => Hotel.fromJson(e))
          .toList();

      return data;
    } catch (error) {
      print("getHotelByField -> $error");
      throw error;
    }
  }

  @override
  Future<List<BannerQuick>> getBanner() async {
    try {
      Response response = await DioProvider.request().get("list-banners");

      if (response.data["data"] == null) {
        throw Exception("Error!");
      }

      List<BannerQuick> data = (response.data["data"] as List)
          .map((e) => BannerQuick.fromJson(e))
          .toList();

      return data;
    } catch (error) {
      print("BannerQuick -> $error");
      throw error;
    }
  }

  @override
  Future<Token> login() async {
    try {
      Response response =
          await DioProvider.request().post("customer/login", data: {
        "phone": "0988888869",
        "password": "123456",
        "token_device": "0a2bd63b2dda91df",
        "token_firebase":
            "cxG2vlX3MEA:APA91bEuOTjLh41LHDZap3zGD1AacWmoFIn-r0PxRbLV83SpVWjXPJiUraVWE6DYYgKE_WyP7v8IGimzOtIp0Q-1tvfXuiIxsbyC19kLr4Up9y0Agz9PDJ78ai_oT0p0WUTgBZktSKSy",
        "device_type": "1"
      });

      if (response.data["data"] == null) {
        throw Exception("Error!");
      }

      Token data = Token.fromJson(response.data["data"]);

      // save token if login
      await persistToken(data.accessToken);

      return data;
    } catch (error) {
      print("login -> $error");
      throw error;
    }
  }

  @override
  Future<List<Hotel>> searchHotel() async {
    try {
      Position position = SingletonPosition.getInstance().position;

      Response response = await DioProvider.request().get(
        "search/hotels/v5?lat=${position.latitude}&lng=${position.longitude}&is_map=1&page=1",
      );

      if (response.data["data"] == null) {
        throw Exception("Error!");
      }

      List<Hotel> data = (response.data["data"] as List).map((e) {
        return Hotel.fromJson(e);
      }).toList();

      return data;
    } catch (error) {
      print("searchHotel -> $error");
      throw error;
    }
  }
}
