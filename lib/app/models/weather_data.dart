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
      temperature: map['temperature']?.toDouble() ?? 0.0,
      humidity: map['humidity']?.toDouble() ?? 0.0,
      pressure: map['pressure']?.toDouble() ?? 0.0,
      precipitation: map['precipitation']?.toDouble() ?? 0.0,
      aqi: map['aqi']?.toInt() ?? 0,
      timestamp: map['timestamp'] ?? '',
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