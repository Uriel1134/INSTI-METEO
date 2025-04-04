import 'package:flutter/material.dart';

import '../../accueil/view/accueil.dart';
import '../../splashTwo/view/splashTwo.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
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
              top: -35,
              child: Container(
                width: 493,
                height: 493,
                child: Image.asset(
                  "assets/images/Cloud 3 zap.png",
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
                  'Bienvenue sur INSTI Weather',
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
              top: 511,
              child: SizedBox(
                width: 241,
                child: Text(
                  'Découvrez une application qui vous permet de surveiller la météo en temps réel avec des données précises.',
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
                      left: 19,
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SplashTwo(),));
                      },
                      child: Image.asset("assets/images/Group 2.png")
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
