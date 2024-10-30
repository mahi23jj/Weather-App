
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService{
  final String forcasturl="https://api.weatherapi.com/v1/forecast.json";
  final String searchurl="https://api.weatherapi.com/v1/search.json";
   final String apikey="b3e44dcf64874e44988213516241008";
   Future<Map<String,dynamic>> featchcurrentweather(String cityname)async{
    final response=await http.get(Uri.parse("$forcasturl?key=$apikey&q=$cityname&days=1&aqi=no&alerts=no"));
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Failed to load weather");
    }
   }
  Future<Map<String,dynamic>> featch7dayforcast(String cityname)async{
    final response=await http.get(Uri.parse("$forcasturl?key=$apikey&q=$cityname&days=7&aqi=no&alerts=no"));
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Failed to forcast data");
    }
   }

   Future<List<dynamic>?> featchsearchcity(String cityname)async{
    final response=await http.get(Uri.parse("$searchurl?key=$apikey&q=$cityname"));
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      return null;
   }

   }

}
  
