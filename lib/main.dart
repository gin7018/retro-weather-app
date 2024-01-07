// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app_ui/days_forecast_widget.dart';
import 'package:weather_app_ui/hour_forecast_widget.dart';
import 'package:weather_app_ui/small_card.dart';
import 'package:weather_app_ui/styles.dart';
import 'package:weather_app_ui/weather_data_provider.dart';
import 'package:string_2_icon/string_2_icon.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'IBM Plex Mono',
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

class WeatherWidgetState extends State<WeatherWidget>
    with WidgetsBindingObserver {
  late WeatherStatus status;
  late ColorThemeSetter currentTheme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentTheme = sunnyTheme;
  }

  Future<void> initializeWeatherStatus() async {
    status = (await fetchWeatherStatus())!;

    if (status.h24Forecast[0].date.hour >= 6) {
      currentTheme = nightTheme;
    } else if (status.icon.contains("cloudy")) {
      currentTheme = cloudyTheme;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    status = (await fetchWeatherStatus())!;
    currentTheme = sunnyTheme;

    if (status.h24Forecast[0].date.hour >= 6) {
      currentTheme = nightTheme;
    } else if (status.icon.contains("cloudy")) {
      currentTheme = cloudyTheme;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeWeatherStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.only(top: 200, left: 100, right: 100),
              color: currentTheme.background,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("LOADING...",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                  ),
                  LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                  )
                ],
              ),
            );
          }
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: currentTheme.background,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 100, left: 100, right: 100),
                      child: Column(
                        children: [
                          Text(
                            status.cityLocation,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${status.currentTemperature.round()}°",
                            style: const TextStyle(fontSize: 80),
                          ),
                          Image.asset(
                            "assets/3rd-set-color-weather-icons/${status.icon}.png",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
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
                                Text("L: ${status.lowestTemperature.round()}°"),
                                const Spacer(),
                                Text(
                                    "H: ${status.highestTemperature.round()}°"),
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
                      decoration: currentTheme.containerDeco,
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
                                child: Text("HOURLY FORECAST"),
                              ),
                            ],
                          ),
                          Container(
                            color: currentTheme.boxColor,
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
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
                        decoration: currentTheme.containerDeco,
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
                                  child: Text("10 DAY FORECAST"),
                                ),
                              ],
                            ),
                            Container(
                                color: currentTheme.boxColor,
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: DaysForeCastWidget(
                                    d10Forecasts: status.tenDayForecast)),
                          ],
                        )),
                    Column(
                      children: [
                        SmallInfoCard(
                            cardDeco: currentTheme,
                            cardTitle: "HUMIDITY",
                            cardBody: "77%",
                            description: "dew point is 65 right now"),
                        SmallInfoCard(
                            cardDeco: currentTheme,
                            cardTitle: "HUMIDITY",
                            cardBody: "77%",
                            description: "dew point is 65 right now"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
