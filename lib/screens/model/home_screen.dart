import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/model/future.dart';
import 'package:weather/service/weather_service.dart';

class MyHomePage extends StatefulWidget {
  String city;

  MyHomePage({super.key, required this.city});
 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherService w = WeatherService();

  Map<String,dynamic>? currentweather;
  Future<void> featchcurrentweather()async{
   Map<String,dynamic>? x=await w.featchcurrentweather(widget.city);
   setState(() {
     currentweather=x;
   });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        decoration: BoxDecoration(
          
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                //  currentweather!['current']['temp_c'] < 25
                //       ? const Color.fromARGB(255, 61, 61, 61)
                // //       : Color.fromARGB(255, 2, 41, 80)
                // (currentweather != null && currentweather!['current']['temp_c'] < 25)
                 const Color.fromARGB(255, 61, 61, 61),
                 const Color.fromARGB(255, 2, 41, 80),
                
                ]
    
        
            ),
          //   image: DecorationImage(
          //   image: AssetImage(widget.img),
          //   fit: BoxFit.cover,
          //   opacity: 0.8,
          // )
            ),
        child: FutureBuilder(
          future: w.featchcurrentweather(widget.city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docs = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Center(
                      child: Column(children: [
                        Image.network(
                          'http:${docs['current']['condition']['icon']}',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Text(docs['location']['name'].toString(),style: GoogleFonts.lato(
                        //    fontSize: 36,
                        //    color: Colors.white,
                        //    fontWeight: FontWeight.bold
                        //    ),),

                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${docs['current']['temp_c'].round()}°C',
                          style: GoogleFonts.lato(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap:(){
                           // _showcity();
                          } ,
                          child: Text(
                            docs['current']['condition']['text'],
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              color: Colors.white,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'max: ${docs['forecast']['forecastday'][0]['day']['maxtemp_c']}°C',
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'min: ${docs['forecast']['forecastday'][0]['day']['mintemp_c']}°C',
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                'Today',
                                style: GoogleFonts.lato(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap:() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return complete();
                                },));
                              },
                              child: Text(
                                'view full forcast',
                                style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildListTile(
                                'Sunrise',
                                Icons.wb_sunny,
                                docs['forecast']['forecastday'][0]['astro']
                                    ['sunrise']),
                            _buildListTile(
                                'Sunset',
                                Icons.brightness_3,
                                docs['forecast']['forecastday'][0]['astro']
                                    ['sunset']),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildListTile('Humidity', Icons.opacity,
                                docs['current']['humidity']),
                            _buildListTile('Wind (KPH)', Icons.wind_power,
                                docs['current']['wind_kph']),
                          ],
                        )
                      ]),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildListTile(String label, IconData icon, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 130,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                value is String ? value : value.toString(),
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ]),
          )),
    ),
  );
}
