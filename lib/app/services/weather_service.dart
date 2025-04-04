import 'package:firebase_database/firebase_database.dart';
import '../models/weather_data.dart';
import 'package:intl/intl.dart';

class WeatherService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final String _nodePath = 'weather_data';

  // Récupérer les données en temps réel
  Stream<WeatherData> getWeatherDataStream() {
    return _database
        .child(_nodePath)
        .onValue
        .map((event) {
          if (event.snapshot.value == null) {
            return WeatherData(
              temperature: 0.0,
              humidity: 0.0,
              pressure: 0.0,
              precipitation: 0.0,
              aqi: 0,
              timestamp: '',
            );
          }
          
          final data = Map<String, dynamic>.from(event.snapshot.value as Map);
          return WeatherData.fromMap(data);
        });
  }

  // Ajouter de nouvelles données
  Future<void> addWeatherData(WeatherData data) async {
    await _database.child(_nodePath).set(data.toMap());
  }

  // Mettre à jour les données
  Future<void> updateWeatherData(WeatherData data) async {
    await _database.child(_nodePath).update(data.toMap());
  }

  // Ajouter des données avec un timestamp sous forme de chaîne
  Future<void> ajouterDonneesWeather() async {
    final String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await _database.child(_nodePath).set({
      "temperature": 25.5,
      "humidity": 60.0,
      "pressure": 1013.25,
      "precipitation": 0.0,
      "aqi": 45,
      "timestamp": formattedTimestamp,
    });
  }
} 