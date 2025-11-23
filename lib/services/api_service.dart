import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_whiz/models/current_weather.dart';
import 'package:weather_whiz/models/forecast_weather.dart';

class ApiService {
  final String baseUrl;
  final String apiKey;

  ApiService({required this.baseUrl, required this.apiKey});

  // Fetch current weather
  Future<CurrentWeather> fetchCurrentWeather(String city) async {
    if (city.isEmpty) {
      throw Exception('City name cannot be empty');
    }

    final url = '$baseUrl/weather?q=$city&appid=$apiKey';
    print('Fetching current weather: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('API Response: $responseData'); // Debug log for API response
      return CurrentWeather.fromJson(responseData);
    } else {
      throw Exception('Failed to load current weather: ${response.statusCode} - ${response.body}');
    }
  }

  // Fetch weather forecast
  Future<List<ForecastWeather>> fetchForecast(String city) async {
    if (city.isEmpty) {
      throw Exception('City name cannot be empty');
    }

    final url = '$baseUrl/forecast?q=$city&cnt=3&appid=$apiKey';
    print('Fetching forecast: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> forecastList = data['list'];

      return forecastList
          .map((item) => ForecastWeather.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load forecast: ${response.statusCode} - ${response.body}');
    }
  }
}