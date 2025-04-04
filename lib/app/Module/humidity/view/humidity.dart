import 'package:flutter/material.dart';

class Humidity extends StatefulWidget {
  const Humidity({super.key});


  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  double temperature = 59;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Humidity",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.08,
                ),
              ),
              Container(
                width:50,
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
      ),

      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/img.png"),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ),

          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 401,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/nuage.png"),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),

          Positioned(
            left: 146.83,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 401,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Sun.png"),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Container(
                  width: 100,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/Vector.png",
                        width: 14,
                        height: 20,
                      ),
                      SizedBox(width: 10,),
                      Text(
                          "Humidity",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$temperature",
                        style: TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "%",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Résumé quotidien',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFAD01),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        height: 0.09,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  padding: EdgeInsets.all(8),
                  width: 340,
                  height: 81,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.20000000298023224),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 304,
                        height: 21,
                        child: Text(
                          "Aujourd'hui, l'humidité moyenne est de $temperature %.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "A propos de l'humidité relative",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFAD01),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        height: 0.09,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  padding: EdgeInsets.only(
                    top: 17,
                    left: 15,
                    right: 15,
                    bottom: 17,
                  ),
                  width: 340,
                  height: 206,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0.20000000298023224),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 304,
                        height: 176,
                        child: Text(
                          "L'humidité relative, communément appelée humidité, est la quantité d'humidité présente dans l'air par rapport à ce qu'il peut contenir. L’air peut retenir plus d’humidité à des températures plus élevées. Une humidité relative proche de 100 % signifie qu'il peut y avoir de la rosée ou du brouillard.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50,),

              ],
            ),
          )


        ]
        ),
      );
  }
}
