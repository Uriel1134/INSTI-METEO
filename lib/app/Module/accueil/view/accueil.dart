import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:insti_meteo/app/Module/humidity/view/humidity.dart';
import 'package:insti_meteo/app/Module/precipitation/view/precipitation.dart';
import 'package:insti_meteo/app/Module/qualityAir/view/qualityAir.dart';
import 'package:insti_meteo/app/models/weather_data.dart';
import 'package:insti_meteo/app/services/weather_service.dart';
import 'package:intl/intl.dart';
import 'package:insti_meteo/app/Module/historique/history.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async'; // Import nécessaire pour le Timer

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  final WeatherService _weatherService = WeatherService();
  WeatherData? _currentWeather;
  String _currentTime = '';
  String _location = '';

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _setupWeatherStream();
    _getCurrentTime();
    _getLocation();

    // Mettre à jour l'heure chaque minute
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      setState(() {
        _getCurrentTime();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annuler le timer lorsque le widget est supprimé
    super.dispose();
  }

  void _setupWeatherStream() {
    _weatherService.getWeatherDataStream().listen((weatherData) {
      setState(() {
        _currentWeather = weatherData;
      });
    });
  }

  void _getCurrentTime() {
    _currentTime = DateFormat('HH:mm').format(DateTime.now());
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifiez si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Les services de localisation ne sont pas activés.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Les permissions de localisation sont refusées.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Les permissions de localisation sont refusées de façon permanente.");
      return;
    }

    // Obtenez la position actuelle
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _location = 'Lat: \\${position.latitude}, Long: \\${position.longitude}';
      });
    } catch (e) {
      print("Erreur lors de l'obtention de la localisation: \\$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AccueilPage(weatherData: _currentWeather, currentTime: _currentTime, location: _location),
      AirQuality(weatherService: _weatherService),
      const Precipitation(),
      const Humidity(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? Colors.white : Colors.grey),
          Icon(Icons.air, size: 30, color: _selectedIndex == 1 ? Colors.white : Colors.grey),
          Icon(Icons.water_drop, size: 30, color: _selectedIndex == 2 ? Colors.white : Colors.grey),
          Icon(Icons.water, size: 30, color: _selectedIndex == 3 ? Colors.white : Colors.grey),
        ],
        color: Colors.white,
        buttonBackgroundColor: const Color(0xFFFFA701),
        backgroundColor: const Color(0xFF2DABE3),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  final WeatherData? weatherData;
  final String currentTime;
  final String location;

  const AccueilPage({super.key, this.weatherData, required this.currentTime, required this.location});

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFA701),
        ),
      );
    }

    String formattedDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text(
                "INSTI Weather",
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
              decoration: const ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.transparent,
                  shape: OvalBorder(),
                ),
              ),
            ],
          ),
        ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Container(
              height: 401,
            decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/nuage.png"),
                    fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                      Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          formattedDate,
                    style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Flexible(
                      child: Image.asset(
                        _getWeatherImage(weatherData!.temperature),
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "${weatherData!.temperature}°C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                      "Pression: ",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                                      Text(
                      " ${weatherData!.pressure}hPa",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                        fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                const SizedBox(height: 20),
                                  Text(
                  _getTemperatureComment(weatherData!.temperature),
                  style: const TextStyle(
                                        color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()), // Assurez-vous que `HistoryPage` est défini
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA701), // Couleur du bouton
                  ),
                  child: const Text("Voir l'historique"),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 340,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                  child: Column(
                    children: [
                      _buildWeatherInfo("Humidité", "${weatherData!.humidity}%", 'assets/images/Vector.png'),
                      _buildWeatherInfo("Précipitations", "${weatherData!.precipitation}mm", 'assets/images/Moon cloud mid rain.png'),
                      _buildWeatherInfo("Qualité de l'air", "${weatherData!.aqi}", 'assets/images/AirQuality.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getWeatherImage(double temperature) {
    if (temperature >= 0 && temperature <= 10) {
      return 'assets/images/Snow Cloud.png'; // Image pour les températures froides
    } else if (temperature > 10 && temperature <= 20) {
      return 'assets/images/Snow Cloud.png'; // Image pour les températures fraîches
    } else if (temperature > 20 && temperature <= 30) {
      return 'assets/images/Group.png'; // Image pour les températures chaudes
    } else if (temperature > 30 && temperature <= 40) {
      return 'assets/images/1.png'; // Image pour les températures très chaudes
    } else if (temperature > 40 && temperature <= 50) {
      return 'assets/images/1.png'; // Image pour les températures très chaudes
    } else {
      return 'assets/images/cloud 3 zap.png'; // Image par défaut pour les températures hors plage
    }
  }

  String _getTemperatureComment(double temperature) {
    if (temperature >= 0 && temperature <= 10) {
      return "Il fait très froid, couvrez-vous bien !";
    } else if (temperature > 10 && temperature <= 20) {
      return "Il fait frais, une veste légère est conseillée.";
    } else if (temperature > 20 && temperature <= 30) {
      return "Le temps est agréable.";
    } else if (temperature > 30 && temperature <= 40) {
      return "Il fait chaud, restez hydraté !";
    } else if (temperature > 40 && temperature <= 50) {
      return "Il fait très chaud, évitez de sortir !";
    } else {
      return "Température hors plage, vérifiez les données.";
    }
  }

  Widget _buildWeatherInfo(String label, String value, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 24, // Ajustez la taille selon vos besoins
            height: 24,
            fit: BoxFit.contain,
          ),
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