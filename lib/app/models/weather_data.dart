class WeatherData {
  final double temperature;
  final double humidity;
  final double pressure;
  final double precipitation;
  final int aqi;
  final String timestamp;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.precipitation,
    required this.aqi,
    required this.timestamp,
  });

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      temperature: (map['temperature'] ?? 0.0).toDouble(),
      humidity: (map['humidity'] ?? 0.0).toDouble(),
      pressure: (map['pressure'] ?? 0.0).toDouble(),
      precipitation: (map['precipitation'] ?? 0.0).toDouble(),
      aqi: (map['aqi'] ?? 0).toInt(),
      timestamp: map['timestamp']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'pressure': pressure,
      'precipitation': precipitation,
      'aqi': aqi,
      'timestamp': timestamp,
    };
  }
} 