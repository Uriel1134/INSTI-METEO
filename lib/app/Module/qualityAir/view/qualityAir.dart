import 'package:flutter/material.dart';
import 'dart:math';
import 'package:insti_meteo/app/models/weather_data.dart';
import 'package:insti_meteo/app/services/weather_service.dart';

class AirQuality extends StatefulWidget {
  final WeatherService weatherService;

  const AirQuality({super.key, required this.weatherService});

  @override
  State<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WeatherData>(
      stream: widget.weatherService.getWeatherDataStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final weatherData = snapshot.data!;
        final aqi = weatherData.aqi.toDouble();
        final pollutant = _calculatePollutant(aqi);
        final commentAQI = _getAQIComment(aqi);
        final meaning = _getAQIMeaning(aqi);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Air Quality",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.08,
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/img.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/fond.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 314,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Air Quality",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: const Size(120, 120),
                                            painter: AQIGaugePainter(aqi),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                aqi.toInt().toString(),
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                commentAQI,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("US EPA AQI", style: TextStyle(fontSize: 14, color: Colors.white70)),
                                    Text("${aqi.toInt()}/500", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                    SizedBox(height: 8),
                                    Text("Polluant dominant", style: TextStyle(fontSize: 14, color: Colors.white70)),
                                    Text(pollutant, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "À propos de la qualité de l'air",
                          style: TextStyle(
                            color: Color(0XFFFFAD01),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Container(
                        width: 314,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Text(
                          meaning,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 400),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _calculatePollutant(double aqi) {
    if (aqi <= 50) return "PM 2.5";
    if (aqi <= 100) return "PM 10";
    if (aqi <= 150) return "Ozone";
    if (aqi <= 200) return "NO2";
    if (aqi <= 300) return "SO2";
    return "CO";
  }

  String _getAQIComment(double value) {
    if (value <= 50) return "Bon";
    if (value <= 100) return "Modéré";
    if (value <= 150) return "Malsain pour les groupes sensibles";
    if (value <= 200) return "Malsain";
    if (value <= 300) return "Très malsain";
    return "Dangereux";
  }

  String _getAQIMeaning(double value) {
    if (value <= 50) return "La qualité de l'air est jugée satisfaisante et la pollution ne pose aucun risque.";
    if (value <= 100) return "La qualité de l'air est acceptable, mais certaines personnes sensibles peuvent être affectées.";
    if (value <= 150) return "Les groupes sensibles peuvent ressentir des effets sur la santé. La population générale n'est pas affectée.";
    if (value <= 200) return "Tout le monde peut commencer à ressentir des effets sur la santé.";
    if (value <= 300) return "Alerte sanitaire : tout le monde peut ressentir des effets plus graves sur la santé.";
    return "Avertissement d'urgence : toute la population est susceptible d'être affectée.";
  }
}

class AQIGaugePainter extends CustomPainter {
  final double aqi;
  AQIGaugePainter(this.aqi);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Shader gradient = SweepGradient(
      startAngle: 3 * pi / 4,
      endAngle: 9 * pi / 4,
      colors: [Colors.green, Colors.yellow, Colors.orange, Colors.red, Colors.purple, Colors.brown],
    ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2));

    paint.shader = gradient;

    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2.2);
    canvas.drawArc(rect, 3 * pi / 4, 3 * pi / 2, false, paint);

    double angle = 3 * pi / 4 + (aqi / 500) * (3 * pi / 2);
    double markerX = (size.width / 2) + cos(angle) * (size.width / 2.2);
    double markerY = (size.height / 2) + sin(angle) * (size.width / 2.2);

    Paint markerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(markerX, markerY), 5, markerPaint);

    TextPainter textPainter0 = TextPainter(
      text: const TextSpan(
        text: "0",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter0.paint(canvas, Offset(5, size.height - 15));

    TextPainter textPainter500 = TextPainter(
      text: const TextSpan(
        text: "500",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter500.paint(canvas, Offset(size.width - 25, size.height - 15));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
