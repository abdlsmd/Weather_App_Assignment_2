import 'package:get/get.dart';

import 'package:weather_whiz/config/app_contants.dart';
import 'package:weather_whiz/controllers/weather_controller.dart';
import 'package:weather_whiz/services/api_service.dart';
import 'package:weather_whiz/services/local_storage_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Instantiate services
    Get.put(ApiService(baseUrl: AppConstants.baseUrl, apiKey: AppConstants.apiKey));
    Get.put(LocalStorageService());

    // Instantiate controller and inject dependencies
    Get.put(
      WeatherController(
        apiService: Get.find<ApiService>(),
        storageService: Get.find<LocalStorageService>(),
      ),
    );
  }
}