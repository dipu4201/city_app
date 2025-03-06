import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveUserLogin(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
