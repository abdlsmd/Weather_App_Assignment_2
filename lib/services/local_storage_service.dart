import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _lastCityKey = 'last_searched_city';

  // Save the last searched city
  Future<void> saveLastCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCityKey, cityName);
  }

  // Retrieve the last searched city
  Future<String?> getLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastCityKey);
  }
}