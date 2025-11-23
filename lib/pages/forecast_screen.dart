import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_whiz/controllers/weather_controller.dart';
import 'package:weather_whiz/models/forecast_weather.dart';

class ForecastScreen extends StatelessWidget {
  final WeatherController weatherController = Get.find<WeatherController>();

  ForecastScreen({Key? key}) : super(key: key);

  String _shortDate(String raw) {
    // Expect formats like "2025-11-23 12:00:00" or similar; return only the date or a nicer format.
    try {
      if (raw.contains(' ')) return raw.split(' ').first;
      return raw;
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3-Day Forecast'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (weatherController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (weatherController.hasError.value || weatherController.forecast == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error loading forecast: ${weatherController.errorMessage.value}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final List<ForecastWeather> forecasts =
            (weatherController.forecast as List<ForecastWeather>?) ?? [];

        if (forecasts.isEmpty) {
          return const Center(
            child: Text('No forecast data available.', style: TextStyle(fontSize: 16)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: forecasts.length,
          itemBuilder: (context, index) {
            final forecast = forecasts[index];
            final dateText = _shortDate(forecast.date);

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Icon + description (responsive)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon fixed size
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: forecast.iconCode.isNotEmpty
                              ? Image.network(
                                  // Use OpenWeatherMap icons by default (adjust if you use another provider)
                                  'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.cloud_off,
                                    size: 36,
                                    color: Colors.grey,
                                  ),
                                )
                              : const Icon(Icons.cloud, size: 36, color: Colors.grey),
                        ),

                        const SizedBox(width: 12),

                        // Description expands to avoid overflow
                        Expanded(
                          child: Text(
                            forecast.description.capitalizeFirst ?? '',
                            style: const TextStyle(fontSize: 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Min/Max Temp - use Expanded so columns share space
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Min Temp:'),
                              Text('${forecast.minTemperature.toStringAsFixed(1)}°C'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Max Temp:'),
                              Text('${forecast.maxTemperature.toStringAsFixed(1)}°C'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}