// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app_ui/forecast_widgets/days_forecast_widget.dart';
import 'package:weather_app_ui/forecast_widgets/hour_forecast_widget.dart';
import 'package:weather_app_ui/cards/small_card.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/data_provider/weather_data_provider.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<StatefulWidget> createState() => WeatherWidgetState();
}

class WeatherWidgetState extends State<WeatherWidget>
    with WidgetsBindingObserver {
  late WeatherStatus status;
  static ColorThemeSetter currentTheme = sunnyTheme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> initializeWeatherStatus() async {
    status = (await fetchWeatherStatus())!;
    print("the statusssss ${status.toString()}");

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
              padding: const EdgeInsets.only(top: 400, left: 100, right: 100),
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
                      padding:
                          const EdgeInsets.only(top: 100, left: 80, right: 80),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              status.cityLocation.toUpperCase(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${status.currentTemperature.round()}°",
                                style: const TextStyle(fontSize: 60),
                              ),
                              Image.asset(
                                "assets/3rd-set-color-weather-icons/${status.icon}.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(status.weatherDescription.toUpperCase(),
                                style: const TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("L: ${status.lowestTemperature.round()}°",
                                    style: const TextStyle(fontSize: 20)),
                                const Spacer(),
                                Text("H: ${status.highestTemperature.round()}°",
                                    style: const TextStyle(fontSize: 20)),
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
                            cardTitle: "CLOUD COVER",
                            cardBody: "${status.cloudCover}%"),
                        SmallInfoCard(
                            cardDeco: currentTheme,
                            cardTitle:
                                "CHANCE OF ${status.precipitationType.toUpperCase()}",
                            cardBody: "${status.precipitationProb}%"),
                        SmallInfoCard(
                            cardDeco: currentTheme,
                            cardTitle: "UV INDEX",
                            cardBody: "${status.uvIndex}"),
                        SmallInfoCard(
                            cardDeco: currentTheme,
                            cardTitle: "HUMIDITY",
                            cardBody: "${status.humidity}%"),
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
