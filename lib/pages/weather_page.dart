import 'package:flutter/material.dart';
import 'package:weather_app_flutter/modals/weather_model.dart';
import 'package:weather_app_flutter/services/weather_services.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("6f237ec41cba9c352af3409e2684f481");
  Weather? _weather;

  // get weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();
    // get weather for the current city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(
        () {
          _weather = weather;
        },
      );
    } //print if any error occurs
    catch (e) {
      print(e.toString());
    }
  }
  // weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/default.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";
      case "thunderstorm":
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/default.json";
    }
  }

  // init state
  @override
  void initState() {
    // fetch weather on startup
    _fetchWeather();
    super.initState();
  }

  TextStyle style() {
    return const TextStyle(
        color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading ...",
              style: style(),
            ),
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),
            Text(
              (_weather != null) ? "${_weather!.temperature.toInt()}*F" : "",
              style: style(),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: style(),
            )
          ],
        ),
      ),
    );
  }
}
