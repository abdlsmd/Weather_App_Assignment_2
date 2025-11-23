import 'package:get/get.dart';
import '../models/current_weather.dart';
import '../models/forecast_weather.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class WeatherController extends GetxController {
  // API and loading states
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Data (make reactive)
  Rxn<CurrentWeather> currentWeather = Rxn<CurrentWeather>();
  var forecast = <ForecastWeather>[].obs;

  // User input
  var cityName = ''.obs;

  // Dependency Injection
  final ApiService apiService;
  final LocalStorageService storageService;

  WeatherController({required this.apiService, required this.storageService});

  @override
  void onInit() {
    super.onInit();
    loadLastCity();
  }

  // Fetch current weather and forecast
  Future<void> fetchWeather(String city) async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final current = await apiService.fetchCurrentWeather(city);
      final f = await apiService.fetchForecast(city);

      currentWeather.value = current;
      forecast.assignAll(f);

      // Cache the city
      await storageService.saveLastCity(city);
      cityName(city);
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Load last searched city on app start
  void loadLastCity() async {
    final lastCity = await storageService.getLastCity();
    if (lastCity != null && lastCity.isNotEmpty) {
      fetchWeather(lastCity);
    }
  }
}