import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_whiz/controllers/weather_controller.dart';
import 'package:weather_whiz/widgets/city_search_bar.dart';
import 'package:weather_whiz/widgets/loading_widget.dart';
import 'package:weather_whiz/main.dart';
import 'package:weather_whiz/models/current_weather.dart';
import 'package:weather_whiz/widgets/weather_card.dart';
import 'package:weather_whiz/widgets/weather_extra_card.dart';
import 'package:weather_whiz/widgets/weather_astronomy_card.dart';
import 'package:weather_whiz/pages/forecast_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // Helper that extracts CurrentWeather regardless of whether controller stores Rxn or plain
  CurrentWeather? _extractCurrentWeather(WeatherController controller) {
    final dynamic cw = controller.currentWeather;
    if (cw == null) return null;

    if (cw is Rxn) return cw.value as CurrentWeather?;
    if (cw is Rx<CurrentWeather>) return cw.value;
    if (cw is CurrentWeather) return cw;
    // fallback (if controller field changed shape)
    try {
      return cw as CurrentWeather?;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtain controllers inside build (after bindings are registered)
    final WeatherController weatherController = Get.find<WeatherController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
              ),
            ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.view_day),
            tooltip: '3-Day Forecast',
            onPressed: () {
              Get.to(() => ForecastScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        // Read reactive state inside Obx so UI updates correctly
        if (weatherController.isLoading.value) {
          return const Center(child: LoadingWidget());
        }

        if (weatherController.hasError.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${weatherController.errorMessage.value}',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final city = weatherController.cityName.value;
                      if (city.isNotEmpty) weatherController.fetchWeather(city);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final current = _extractCurrentWeather(weatherController);

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CitySearchBar(
                  onSubmitted: (city) {
                    final trimmed = city.trim();
                    if (trimmed.isNotEmpty) weatherController.fetchWeather(trimmed);
                  },
                ),
                const SizedBox(height: 20),

                if (current == null) ...[
                  const SizedBox(height: 40),
                  Text(
                    'Search for a city to view current weather.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ],

                if (current != null) ...[
                  WeatherCard(weather: current),
                  const SizedBox(height: 12),
                  WeatherExtraCard(weather: current),
                  const SizedBox(height: 12),
                  WeatherAstronomyCard(weather: current),
                  const SizedBox(height: 20),

                  // Use Wrap to avoid horizontal overflow on small screens
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 360 ? (MediaQuery.of(context).size.width / 2 - 24) : 160,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final city = weatherController.cityName.value;
                            if (city.isNotEmpty) weatherController.fetchWeather(city);
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 360 ? (MediaQuery.of(context).size.width / 2 - 24) : 160,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => ForecastScreen());
                          },
                          icon: const Icon(Icons.schedule),
                          label: const Text('Forecast'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}