class ForecastWeather {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final String description;
  final String iconCode;

  ForecastWeather({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.iconCode,
  });

  // Factory method to create an object from JSON
  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
      date: json['dt_txt'] ?? 'Unknown date',
      minTemperature: (json['main']['temp_min'] ?? 0).toDouble(),
      maxTemperature: (json['main']['temp_max'] ?? 0).toDouble(),
      description: json['weather']?[0]['description'] ?? 'No description',
      iconCode: json['weather']?[0]['icon'] ?? '',
    );
  }
}