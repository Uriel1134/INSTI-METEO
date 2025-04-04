import 'package:flutter/material.dart';
import 'package:insti_meteo/app/models/weather_data.dart';
import 'package:intl/intl.dart';

class AccueilPage extends StatelessWidget {
  final WeatherData? weatherData;

  const AccueilPage({super.key, this.weatherData});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFA701),
        ),
      );
    }

    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    dateFormat.format(now),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    timeFormat.format(now),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${weatherData!.temperature}°C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Ressenti ${weatherData!.realFeel}°C | Altitude: ${weatherData!.altitude}m",
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    _buildWeatherInfo(
                      "Humidité",
                      "${weatherData!.humidity}%",
                      Icons.water_drop,
                    ),
                    _buildWeatherInfo(
                      "Précipitations",
                      "${weatherData!.precipitation}%",
                      Icons.umbrella,
                    ),
                    _buildWeatherInfo(
                      "Qualité de l'air",
                      "${weatherData!.aqi}",
                      Icons.air,
                    ),
                    _buildWeatherInfo(
                      "Probabilité de pluie",
                      "${weatherData!.chanceOfRain}%",
                      Icons.cloud,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 