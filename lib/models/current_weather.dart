import 'package:flutter/foundation.dart';

class CurrentWeather {
  final String cityName;
  final double temperature;
  final String description;
  final double humidity;
  final double windSpeed;
  final String iconCode;

  final double feelsLike;
  final int pressure;
  final int clouds;
  final int visibility;
  final double windDegree;
  final DateTime? sunrise;
  final DateTime? sunset;

  CurrentWeather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.iconCode,
    required this.feelsLike,
    required this.pressure,
    required this.clouds,
    required this.visibility,
    required this.windDegree,
    required this.sunrise,
    required this.sunset,
  });

  static double _parseTemp(dynamic value) {
    if (value == null) return 0.0;
    final numVal = value is num ? value.toDouble() : double.tryParse(value.toString()) ?? 0.0;
    if (numVal > 100) return (numVal - 273.15); // likely Kelvin -> convert to Celsius
    return numVal; // already Celsius
  }

  static DateTime? _parseUnixToLocal(dynamic sec) {
    if (sec == null) return null;
    final intSec = sec is int ? sec : int.tryParse(sec.toString());
    if (intSec == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(intSec * 1000, isUtc: true).toLocal();
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>?;
    final weather = (weatherList != null && weatherList.isNotEmpty) ? weatherList.first as Map<String, dynamic> : <String, dynamic>{};
    final main = (json['main'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final wind = (json['wind'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final cloudsMap = (json['clouds'] as Map<String, dynamic>?) ?? <String, dynamic>{};
    final sys = (json['sys'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return CurrentWeather(
      cityName: json['name']?.toString() ?? 'Unknown',
      temperature: _parseTemp(main['temp']),
      description: weather['description']?.toString() ?? 'No description',
      humidity: (main['humidity'] is num) ? (main['humidity'] as num).toDouble() : double.tryParse(main['humidity']?.toString() ?? '') ?? 0.0,
      windSpeed: (wind['speed'] is num) ? (wind['speed'] as num).toDouble() : double.tryParse(wind['speed']?.toString() ?? '') ?? 0.0,
      iconCode: weather['icon']?.toString() ?? '',
      feelsLike: _parseTemp(main['feels_like'] ?? main['temp']),
      pressure: (main['pressure'] is num) ? (main['pressure'] as num).toInt() : int.tryParse(main['pressure']?.toString() ?? '') ?? 0,
      clouds: (cloudsMap['all'] is num) ? (cloudsMap['all'] as num).toInt() : int.tryParse(cloudsMap['all']?.toString() ?? '') ?? 0,
      visibility: (json['visibility'] is num) ? (json['visibility'] as num).toInt() : int.tryParse(json['visibility']?.toString() ?? '') ?? 0,
      windDegree: (wind['deg'] is num) ? (wind['deg'] as num).toDouble() : double.tryParse(wind['deg']?.toString() ?? '') ?? 0.0,
      sunrise: _parseUnixToLocal(sys['sunrise']),
      sunset: _parseUnixToLocal(sys['sunset']),
    );
  }
}