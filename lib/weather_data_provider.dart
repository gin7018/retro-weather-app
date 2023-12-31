import 'dart:convert';
// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;

class ForeCast {
  DateTime date;
  double temperature;
  double? low;
  double? high;

  String condition;
  String icon;

  ForeCast(this.date, this.temperature, this.condition, this.icon, this.low,
      this.high);

  factory ForeCast.fromJson(fc) {
    var dt = DateTime.parse(fc["datetime"]);

    return ForeCast(dt, fc["temp"], fc["conditions"], fc["icon"], null, null);
  }
}

class WeatherStatus {
  String cityLocation;
  String weatherDescription;

  double currentTemperature;
  double lowestTemperature;
  double highestTemperature;
  double feelsLike;

  List<ForeCast> h24Forecast;

  WeatherStatus(
      this.cityLocation,
      this.weatherDescription,
      this.currentTemperature,
      this.lowestTemperature,
      this.highestTemperature,
      this.feelsLike,
      this.h24Forecast);

  factory WeatherStatus.fromJson(Map<String, dynamic> jstat) {
    developer.log("the length of hours: ${jstat["days"][0]["hours"]}");
    return WeatherStatus(
        jstat["resolvedAdress"] as String,
        jstat["currentConditions"]["conditions"],
        jstat["currentConditions"]["temp"],
        jstat["days"][0]["tempmin"],
        jstat["days"][0]["tempmax"],
        jstat["currentConditions"]["feelslike"],
        (jstat["days"][0]["hours"] as List)
            .map((e) => ForeCast.fromJson(e))
            .toList());
  }
}

Future<WeatherStatus?> fetchWeatherStatus() async {
  // need to ask user to share their location
  String include = "days,hours,alerts,current";
  Position location;

  LocationPermission serviceEnabled = await Geolocator.checkPermission();
  if (serviceEnabled == LocationPermission.denied) {
    serviceEnabled = await Geolocator.requestPermission();
  }

  location = await Geolocator.getCurrentPosition();

  final statusRequest = await http.get(Uri(
      scheme: "https",
      host: "weather.visualcrossing.com",
      path: "VisualCrossingWebServices/rest/services/timeline/",
      queryParameters: {
        "key": "MDCQ6R9Z6U4NKDJD8JNXNWGR8",
        "lang": "en",
        "location": "${location.latitude},${location.longitude}",
        "date1": DateTime.now(),
        "include": include,
        "elements": "tempmax,tempmin,temp",
        "options": "noheaders"
      }));

  if (statusRequest.statusCode == 200) {
    return WeatherStatus.fromJson(
        jsonDecode(statusRequest.body) as Map<String, dynamic>);
  }
  return null;
}
