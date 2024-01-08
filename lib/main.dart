import 'package:flutter/material.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/pages/city_search.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // fontFamily: 'IBM Plex Mono',
          fontFamily: "Retro Gaming",
          textTheme: const TextTheme().copyWith(
            bodySmall: const TextStyle(color: Colors.white),
            bodyMedium: const TextStyle(color: Colors.white),
            bodyLarge: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      home: CitySearchWidget(
        currentTheme: nightTheme,
      ),
    );
  }
}
