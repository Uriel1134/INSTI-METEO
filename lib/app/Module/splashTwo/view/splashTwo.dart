import 'package:flutter/material.dart';
import 'package:insti_meteo/app/Module/accueil/view/accueil.dart';

import '../../splashThree/view/splashThree.dart';

class SplashTwo extends StatelessWidget {
  const SplashTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/unsplash_fa383SvhUsA.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:Stack(
          children: [
            Positioned(
              left: -66,
              top: -45,
              child: Container(
                width: 493,
                height: 493,
                child: Image.asset(
                  "assets/images/Sun cloud little rain.png",
                ),
              ),
            ),
            Positioned(
              left: -66,
              top: 373,
              child: Container(
                width: 493,
                height: 493,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 76,
              top: 435,
              child: SizedBox(
                width: 209,
                child: Text(
                  'Analyse météo complète',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0A0A22),
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 60,
              top: 525,
              child: SizedBox(
                width: 241,
                child: Text(
                  "Visualisez   la   température, l'humidité et la pression sur des graphiques clairs.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8B95A2),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 162,
              top: 350,
              child: Container(
                width: 36,
                height: 6,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 19,
                      top: 0,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: ShapeDecoration(
                          color: Color(0xFF8B95A2),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 11,
                      top: 0,
                      child: Container(
                        width: 14,
                        height: 6,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0A0A22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 0,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 300,
              top: 43,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Accueil(),));
                },
                child: Text(
                  'Skip',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.08,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 140,
              top: 628,
              child: Container(
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashThree(),));
                        },
                        child: Image.asset("assets/images/Group 2 (1).png")
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
}
