import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static late SharedPreferences sharedPreferences;
  // Create Instance
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Get
  static dynamic get(String key) {
    return sharedPreferences.getString(key);
  }

  // Set
  static void setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  // Remove
  static void remove(String key) async {
    await sharedPreferences.remove(key);
  }
}
