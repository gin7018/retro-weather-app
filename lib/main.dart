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
      theme: ThemeData(
          fontFamily: 'Retro Gaming',
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
        "KIGALI", "SUNNY WITH CLOUDS", 80, 74, 79, 75, hourForecasts);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.blue.shade200,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 80, left: 100, right: 100, bottom: 80),
                child: Column(
                  children: [
                    const Text(
                      "MY LOCATION",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      status.cityLocation,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 100, right: 100),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            left: 50,
                            bottom: 50,
                            child: Image.asset(
                              "assets/sunny_clouds.png",
                              width: 200,
                              height: 200,
                            )),
                        Text(
                          "${status.currentTemperature.round()}",
                          style: const TextStyle(fontSize: 100),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(status.weatherDescription),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
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
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    border: Border.all(
                        color: Colors.blue.shade900,
                        width: 5,
                        strokeAlign: BorderSide.strokeAlignCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.access_time_filled_sharp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "HOURLY FORECAST",
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.blue.shade300,
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: HourForecastWidget(
                        forecasts: status.h24Forecast,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      border: Border.all(
                          color: Colors.blue.shade900,
                          width: 5,
                          strokeAlign: BorderSide.strokeAlignCenter)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Icon(Icons.calendar_today_sharp),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "10 DAY FORECAST",
                            ),
                          ),
                        ],
                      ),
                      Container(
                          color: Colors.blue.shade300,
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child:
                              DaysForeCastWidget(d10Forecasts: d10Forecasts)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}