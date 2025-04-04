import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Precipitation extends StatefulWidget {
  const Precipitation({super.key});

  @override
  State<Precipitation> createState() => _PrecipitationState();
}

class _PrecipitationState extends State<Precipitation> {
  double _precipitationValue = 0; // Valeur de la précipitation (en mm)

  /// Retourne la couleur associée à la valeur de précipitation
  Color getBarColor(double value) {
    if (value >= 0 && value < 10) {
      return Colors.white; // Pas de pluie
    } else if (value >= 10 && value < 20) {
      return Colors.blue; // Pluie légère
    } else if (value >= 20 && value <= 35) {
      return Colors.purple; // Pluie modérée
    } else {
      return Color(0xFF021C7C); // Forte pluie/Orage
    }
  }

  /// Génère dynamiquement les données du graphique
  List<BarChartGroupData> getBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          toY: _precipitationValue,
          color: getBarColor(_precipitationValue),
          width: 30,
          borderRadius: BorderRadius.circular(5),
        )
      ]),
    ];
  }

  String getRainType(double value) {
    if (value == 0) {
      return "Pas de pluie";
    } else if (value > 0 && value <= 5) {
      return "Pluie légère";
    } else if (value > 5 && value <= 20) {
      return "Pluie modérée";
    } else {
      return "Forte pluie/Orage";
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _precipitationValue = Random().nextDouble() * 50; // Simulation entre 0 et 50mm
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Precipitation",
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
              decoration: ShapeDecoration(
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
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05), // Espacement initial

                Container(
                  width: 325,
                  height: 245,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.3),
                  ),

                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 50, // Valeur max de précipitation (à ajuster)
                      barGroups: getBarGroups(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              return Text("Actuel", style: TextStyle(color: Colors.white));
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Caché
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, _) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false), // Suppression des lignes de grille
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: Colors.white, width: 1), // Axe du bas visible
                          right: BorderSide(color: Colors.white, width: 1), // Axe de droite visible
                          left: BorderSide.none, // Axe de gauche masqué
                          top: BorderSide.none,
                        ),
                      )
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: 315,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildLegendItem(Color(0xFF021C7C), "Forte pluie/Orage"),
                          _buildLegendItem(Colors.blue, "Pluie légère"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildLegendItem(Colors.purple, "Pluie modérée"),
                          _buildLegendItem(Colors.white, "Pas de pluie"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Résumé quotidien",
                      style: TextStyle(color: Color(0XFFFFAD01), fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: 340,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "Prévision : ${getRainType(_precipitationValue)}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 150), // Espacement initial

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 5),
        Text(text, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
