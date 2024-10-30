import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/model/home_screen.dart';
import 'package:weather/screens/model/paralex.dart';
import 'package:weather/service/weather_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  double _padding=24.0;
  var _spacing=24.0;
  String _city=''; 

    Widget appbar(){
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: _padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.barsStaggered,
              color: Colors.white,
              size: 24,
            ),
            Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 24,
            ),
          ],),
      );
    }
    final  WeatherService w = WeatherService();
    Widget searchbar() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: _padding),
    child: Container(
      decoration: BoxDecoration(
        color:  Colors.grey.withOpacity(0.2), // Set the container color to gray
        borderRadius: BorderRadius.circular(15), // Add rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.search, // Use the correct icon name
              color: Colors.white,
              size: 24,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TypeAheadField(
 builder: (context, controller, focusNode) => TextField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: "Search",
      hintStyle: TextStyle(color: Colors.white),
      border: InputBorder.none,
    ),
    controller: controller,
    focusNode: focusNode,


 ),
  
  suggestionsCallback: (pattern) async {
    // Implement your search logic here
    // Return a list of suggestions based on the search pattern
    return await w.featchsearchcity(pattern);
  },
  onSelected: (city) {
    setState(() {
     _city=city['name'];
     
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  MyHomePage(city: _city,);
    }));
     
    
  },
  itemBuilder: (context, suggestion) {
    // Customize the appearance of each suggestion
    return ListTile(
      title: Text(suggestion['name']),
    );
  },
  // onSuggestionSelected: (suggestion) {
  //   // Handle the selected suggestion here
  //   // For example, update your UI or perform an action
   
  // },
)

              ),
            ),
          
          ],
        ),
      ),
    ),
  );
}  



      // Widget searchbarwithtextfield(){
      //   return Padding(
      //     padding:  EdgeInsets.symmetric(horizontal: _padding),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Icon(
      //           FontAwesomeIcons.magnifyingGlass,
      //           color: Colors.white,
      //           size: 24,
      //         ),
      //         Text(
      //           "Search",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 16,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //         Icon(
      //           FontAwesomeIcons.filter,
      //           color: Colors.white,
      //           size: 24,
      //         ),
      //       ],),
      //   );
      // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 12, 12, 12),
              Color.fromARGB(255, 54, 59, 65),
              Color.fromARGB(255, 70, 75, 77),
              Color.fromARGB(255, 95, 98, 102)
              // Color.fromARGB(255, 0, 1, 2),
              // Color.fromARGB(255, 21, 20, 71),
              // Color.fromARGB(255, 11, 8, 41),
              // Color.fromARGB(255, 8, 9, 53)
            ])),
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            appbar(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:_padding),
              child: Center(
                child: Text('Pick location', style: GoogleFonts.lato(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            searchbar(),
             SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:_padding),
              child: Text('Top countries', style: GoogleFonts.lato(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 60,
            ),
            Paralex()


          ],),
        )
        
        ) ,
    );
  }
}

