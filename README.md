<<<<<<< HEAD
# 🌤 Flutter Weather App

## Overview
A cross-platform mobile Weather App built with [Flutter](https://flutter.dev/) using **GetX** for state management. Fetches weather data from OpenWeatherMap API (or any free weather API).

---

## Features
1. **Platform**: Cross-platform (Flutter).
2. **Weather Search by City**: Enter a city name to fetch weather data instantly.
3. **Current Weather**:
   - Temperature, Description, Humidity, Wind Speed.
   - Weather Icon.
   - Supports dynamic loading states and error handling for better user experience.
4. **3-Day Forecast**: Future weather forecast with:
    - Date, Min/Max Temp, Description, and Icon.
5. **Offline State**: Stores last-searched city so the app loads it upon restart.
6. **Aesthetic UI**: Simple and user-friendly design for a mobile experience.

---

## 📱 Screenshots
| Main Screen | Forecast Screen | Error Screen |
|---|---|---|
| ![Main](screenshots/main_current_weather.png) | ![Forecast](screenshots/forecast.png) | ![Error](screenshots/error.png) |

---

## 🚀 Setup Instructions
### Prerequisites
- Flutter installed (version `>=3.x`).
- Registered and active [OpenWeatherMap API key](https://openweathermap.org/).

---

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/FlutterWeatherApp.git
   cd FlutterWeatherApp
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Place your API key in:
   ```
   lib/config/app_constants.dart
   ```
   Example:
   ```dart
   static const String apiKey = 'YOUR_API_KEY_HERE';
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

### Folder Structure
```
lib/
├── main.dart
├── config/
│   ├── app_constants.dart         # API key and base URL
│   ├── theme.dart                 # Global theme setup
├── controllers/
│   ├── weather_controller.dart    # Manages app logic via GetX
├── models/
│   ├── current_weather.dart       # Current weather data model
│   ├── forecast_weather.dart      # Forecast data model
├── pages/
│   ├── error_screen.dart          # Custom error and retry screen
│   ├── home_screen.dart           # Weather search and main UI
│   ├── forecast_screen.dart       # 3-day forecast
├── services/
│   ├── api_service.dart           # Weather API service (HTTP calls)
│   ├── local_storage_service.dart # Local cache using shared_preferences
├── widgets/
│   ├── weather_card.dart          # Display card for weather info
│   ├── city_search_bar.dart       # Widget for the search bar
│   ├── loading_widget.dart        # Loading animations
├── utils/
│   ├── weather_helper.dart        # Helpers for common utilities
```

---

### Dependencies
| Package             | Usage                                |
|---------------------|--------------------------------------|
| [GetX](https://pub.dev/packages/get) | State management and navigation |
| [HTTP](https://pub.dev/packages/http) | Fetching data from Weather API   |
| [Shared_Preferences](https://pub.dev/packages/shared_preferences)| Persist data locally |

---

### To-Do / Enhancements
- Add more detailed forecasts (e.g., hourly weather).
- Improve offline caching of data.
- Support for multiple languages/localization.

---

### License
This project is licensed under the MIT License. Enjoy building! 🚀
=======
# Weather_App_Assignment_2
>>>>>>> 10cf989da522743c21b6562c3d76f79a9cb01580
