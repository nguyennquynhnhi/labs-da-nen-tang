import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic>? weatherData;

  const LocationScreen({super.key, this.weatherData});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weather = WeatherModel();

  String icon = '☀️';
  int temperature = 0;
  String cityName = '';
  String description = '';
  String message = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(Map<String, dynamic>? data) {
    setState(() {
      if (data == null) {
        icon = '❌';
        temperature = 0;
        cityName = 'Lỗi';
        description = 'Không lấy được dữ liệu';
        message = 'Vui lòng thử lại';
        return;
      }
      int condition = data['weather'][0]['id'];
      icon = weather.getWeatherIcon(condition);
      temperature = data['main']['temp'].toInt();
      cityName = data['name'];
      description = data['weather'][0]['description'];
      message = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              String? city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CityScreen()),
              );
              if (city != null && city.isNotEmpty) {
                var data = await weather.getCityWeather(city);
                updateUI(data);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.white),
            onPressed: () async {
              var data = await weather.getLocationWeather();
              updateUI(data);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon thời tiết + nhiệt độ
              Row(
                children: [
                  Text(icon, style: const TextStyle(fontSize: 80)),
                  const SizedBox(width: 16),
                  Text(
                    '$temperature°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Mô tả thời tiết
              Text(
                description.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),

              // Tên thành phố
              Text(
                cityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1E33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white54),
                    const SizedBox(width: 12),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}