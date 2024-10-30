import 'package:flutter/material.dart';
import 'package:weather/service/weather_service.dart';
import 'package:intl/intl.dart';

class complete extends StatefulWidget {
  const complete({super.key});

  @override
  State<complete> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<complete> {
  Color back = Colors.black;
  Color a = Colors.black.withOpacity(0.1);
  Color b = Color.fromARGB(255, 255, 94, 0);
  WeatherService serv = WeatherService();
    Widget elem(){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
            
        children: [
          IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
                
              Expanded(
                child: Center(
                  child: Text(
                    'Kyiv,Ukrine',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            
        ],
      ),
    );
  }
  
    
    
    // ListTile(
    //   leading: Icon(Icons.location_on, color: Colors.white),
      
    //   title: Text("Location", style: TextStyle(color: Colors.white),),
      
    //   subtitle: Text("New York", style: TextStyle(color: Colors.white),),
    // ); 
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.3;
    double h = w * 1.25;
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
                ]),
            //   image: DecorationImage(
            //   image: AssetImage(widget.img),
            //   fit: BoxFit.cover,
            //   opacity: 0.8,
            // )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child:  Column(
                  children: [
                    elem(),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Next 7 days forecast',style: TextStyle(fontSize: 25,color: Colors.white),),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                        future: serv.featch7dayforcast('London'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                           var docs = snapshot.data!['forecast']['forecastday'];
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(docs.length, (index) {
                                var doc = docs[index];

                                     DateTime date = DateTime.parse(doc['date']);
              String formattedDate = DateFormat('EEEE, d MMMM').format(date);
              String maxTemp = doc["day"]["maxtemp_c"].toString();
              String minTemp = doc["day"]["mintemp_c"].toString();
              String conditionIcon = doc["day"]["condition"]["icon"];
                                return  Padding(
  padding: const EdgeInsets.only(bottom: 20.0),
  child: Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.network(
              "https:$conditionIcon",
              width: 50,
              height: 50,
            ),
            SizedBox(width: 10),
            Text(formattedDate, style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Text(
              maxTemp,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(width: 10),
            Text(
              minTemp,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    ),
  ),
);

                              }),
                            ),
                          );
                        })
                  ],
                ),
              
            
          ),
        ));
  }
}


// GestureDetector(
//                                     onTap: () {
//                                       //  Navigator.push(
//                                       //             context,
//                                       //             MaterialPageRoute(
//                                       //               builder: (context) => form(),
//                                       //             ));
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: a,
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(15.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
                                             
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                    Image.network(
//                                                      conditionIcon,
//                                                       height: 50,
//                                                       width: 50,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                     SizedBox(width: 10),
//                                                     Text(
//                                                       formattedDate,
//                                                       style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                       maxTemp,
//                                                       style: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 14),
//                                                     ),
//                                                     SizedBox(width: 10),
//                                                     Text(
//                                                       minTemp,
//                                                       style: TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 14),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),