import 'package:dio/dio.dart';

class DioProvider {
  static Dio dioBase;
  static Dio dioStorage;
  static Dio diochat;

  static Dio _instance() {
    final dio = Dio();
    dio.options.baseUrl = "https://test.quickstay.vn/api/";
    dio.options.connectTimeout = 10000; //10s
    dio.options.receiveTimeout = 10000;
    dio.options.responseType = ResponseType.json;

    dio.interceptors.add(HttpLogInterceptor());

    return dio;
  }

  static setToken(String token) {
    print("TOKEN LOGIN: $token");
    dioBase.options.headers["Authorization"] = token;
  }

  static Dio request() {
    if (dioBase == null) {
      dioBase = _instance();
    }

    return dioBase;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    print("REQUEST[${options?.method}]\nData: ${options?.data}");
    return options;
  }

  @override
  Future onResponse(Response response) {
    print("RESPONSE[${response?.statusCode}]\nData: ${response?.data}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError e) {
    print("ERROR[$e]");
    return super.onError(e);
  }
}
