import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_flutter/modals/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  // getting the api data
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&unit=metric'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data ,.,.,.,.,.,.,.,..,.");
    }
  }

  // getting the location of the device

  Future<String> getCurrentCity() async {
    // get user permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print("position : $position");

    //convert position into list of placemarks
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print("placemarkList : $placemark");

    String? city = placemark[0].locality;
    print("city in question:: ${city}");
    return "haridwar";
  }
}
