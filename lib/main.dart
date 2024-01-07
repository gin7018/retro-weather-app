// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app_ui/forecast_widgets/days_forecast_widget.dart';
import 'package:weather_app_ui/forecast_widgets/hour_forecast_widget.dart';
import 'package:weather_app_ui/misc/small_card.dart';
import 'package:weather_app_ui/misc/styles.dart';
import 'package:weather_app_ui/data_provider/weather_data_provider.dart';
import 'package:string_2_icon/string_2_icon.dart';

import 'pages/weather_widget.dart';

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
      home: const WeatherWidget(),
    );
  }
}
