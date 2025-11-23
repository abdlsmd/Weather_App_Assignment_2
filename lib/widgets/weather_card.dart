import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/current_weather.dart';

class WeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // City Name
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Temperature and Description
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Temperature
                Flexible(
                  child: Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Description
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.description.capitalizeFirst!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.iconCode.isNotEmpty ? weather.iconCode : "01d"}@2x.png',
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 30),

            // Additional Info: Humidity, Wind Speed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Humidity
                Column(
                  children: [
                    const Text('Humidity'),
                    Text(
                      '${weather.humidity.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                // Wind Speed
                Column(
                  children: [
                    const Text('Wind Speed'),
                    Text(
                      '${weather.windSpeed.toStringAsFixed(1)} m/s',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}