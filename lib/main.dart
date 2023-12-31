// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app_ui/days_forecast_widget.dart';
import 'package:weather_app_ui/hour_forecast_widget.dart';
import 'package:weather_app_ui/weather_data_provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Retro Gaming'),
      home: const WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<StatefulWidget> createState() => WeatherWidgetState();
}

class WeatherWidgetState extends State<WeatherWidget> {
  late WeatherStatus status;

  @override
  void initState() {
    super.initState();
    var dt = DateTime.now();
    List<ForeCast> forecasts = [];
    for (int i = 0; i < 24; i++) {
      dt = dt.add(const Duration(hours: 1));
      forecasts.add(ForeCast(dt, 78, "rain", "rain", null, null));
    }
    status =
        WeatherStatus("KIGALI", "Sunny with Clouds", 80, 74, 79, 75, forecasts);
  }

  @override
  Widget build(BuildContext context) {
    var dt = DateTime.now();
    List<ForeCast> hourForecasts = [];
    for (int i = 0; i < 24; i++) {
      dt = dt.add(const Duration(hours: 1));
      hourForecasts.add(ForeCast(dt, 78, "rain", "rain", null, null));
    }

    List<ForeCast> d10Forecasts = [];
    for (int i = 0; i < 10; i++) {
      dt = dt.add(const Duration(days: 1));
      d10Forecasts.add(ForeCast(dt, 78, "rain", "rain", 75, 80));
    }
    status = WeatherStatus(
        "KIGALI", "Sunny with Clouds", 80, 74, 79, 75, hourForecasts);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 100, right: 100),
              child: Column(
                children: [
                  const Text(
                    "My Location",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    status.cityLocation,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "${status.currentTemperature.round()}",
                    style: const TextStyle(fontSize: 70),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(status.weatherDescription),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("L: ${status.lowestTemperature.round()}"),
                        const Spacer(),
                        Text("H: ${status.highestTemperature.round()}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // the 24 hour forecasts widget
            HourForecastWidget(
              forecasts: status.h24Forecast,
            ),
            DaysForeCastWidget(d10Forecasts: d10Forecasts)
          ],
        ),
      ),
    );
  }
}
