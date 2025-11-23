import 'package:flutter/material.dart';
import '../models/current_weather.dart';

class WeatherExtraCard extends StatelessWidget {
  final CurrentWeather weather;

  const WeatherExtraCard({Key? key, required this.weather}) : super(key: key);

  String _visibilityKm(int meters) {
    final km = meters / 1000;
    return '${km.toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feels Like',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  '${weather.feelsLike.toStringAsFixed(1)}°C',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pressure',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  '${weather.pressure} hPa',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            // Middle divider
            Container(width: 1, height: 70, color: Colors.grey.shade200),

            // Right column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visibility',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  _visibilityKm(weather.visibility),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Cloudiness',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 6),
                Text(
                  '${weather.clouds}%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}