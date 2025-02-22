import 'package:flutter/material.dart';
import 'package:weather/screens/model/future.dart';
import 'package:weather/screens/model/home_screen.dart';
import 'package:weather/screens/model/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'weather App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:menu(),
    );
  }
}

