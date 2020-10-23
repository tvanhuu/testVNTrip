import 'package:shared_preferences/shared_preferences.dart';

Future<bool> hasToken() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    return token != null;
  } catch (error) {
    return false;
  }
}

Future<dynamic> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future<void> persistToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
}

Future<void> deleteToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", null);
}
