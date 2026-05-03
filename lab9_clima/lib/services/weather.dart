import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

const String apiKey = '9f6f951b915bcac3058599f8bb16cf47';
const String openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>?> getLocationWeather() async {
    try {
      Position position = await getCurrentLocation();
      return await fetchWeather(
        '$openWeatherUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=vi',
      );
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCityWeather(String city) async {
    return await fetchWeather(
      '$openWeatherUrl?q=$city&appid=$apiKey&units=metric&lang=vi',
    );
  }

  Future<Map<String, dynamic>?> fetchWeather(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) return '🌩';
    if (condition < 400) return '🌧';
    if (condition < 600) return '☔️';
    if (condition < 700) return '☃️';
    if (condition < 800) return '🌫';
    if (condition == 800) return '☀️';
    if (condition <= 804) return '☁️';
    return '🤷‍';
  }

  String getMessage(int temp) {
    if (temp > 35) return 'Trời rất nóng! 🥵';
    if (temp > 25) return 'Thời tiết dễ chịu 😊';
    if (temp > 15) return 'Hơi lạnh, mặc thêm áo nhé 🧥';
    return 'Trời lạnh lắm! 🥶';
  }
}