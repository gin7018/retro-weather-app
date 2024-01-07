import 'dart:convert';
// import 'dart:html';

// import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
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

  factory ForeCast.dayFromJson(fc) {
    var dt = DateTime.parse(fc["datetime"]);
    return ForeCast(dt, fc["temp"], fc["conditions"], fc["icon"], fc["tempmin"],
        fc["tempmax"]);
  }

  factory ForeCast.hourFromJson(fc, referenceDate) {
    var elements = fc["datetime"].split(":");
    var reference = DateTime.parse(referenceDate);
    var dt = DateTime(reference.year, reference.month, reference.day,
        int.parse(elements[0]), int.parse(elements[1]));
    return ForeCast(dt, fc["temp"], fc["conditions"], fc["icon"], fc["tempmin"],
        fc["tempmax"]);
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
  List<ForeCast> tenDayForecast;

  WeatherStatus(
      this.cityLocation,
      this.weatherDescription,
      this.currentTemperature,
      this.lowestTemperature,
      this.highestTemperature,
      this.feelsLike,
      this.h24Forecast,
      this.tenDayForecast);
}

Future<WeatherStatus> fromJson(Map<String, dynamic> jstat) async {
  developer.log("the length of hours: ${jstat["days"][0]["hours"].length}");

  var now = DateTime.now();
  var startingHour = DateTime(now.year, now.month, now.day, now.hour, 0);

  var bothDaysHourlyStatus = ((jstat["days"][0]["hours"] as List)
          .map((e) => ForeCast.hourFromJson(e, jstat["days"][0]["datetime"]))
          .toList() +
      (jstat["days"][1]["hours"] as List)
          .map((e) => ForeCast.hourFromJson(e, jstat["days"][1]["datetime"]))
          .toList());
  bothDaysHourlyStatus
      .removeWhere((forecast) => forecast.date.isBefore(startingHour));
  bothDaysHourlyStatus = bothDaysHourlyStatus.sublist(0, 24);

  var tenDayWeatherStatus = (jstat["days"] as List)
      .sublist(0, 10)
      .map((e) => ForeCast.dayFromJson(e))
      .toList();

  Address address =
      await retrieveLocationDetails(jstat["latitude"], jstat["longitude"]);

  return WeatherStatus(
      "${address.city}, ${address.countryName}",
      jstat["currentConditions"]["conditions"],
      jstat["currentConditions"]["temp"],
      jstat["days"][0]["tempmin"],
      jstat["days"][0]["tempmax"],
      jstat["currentConditions"]["feelslike"],
      bothDaysHourlyStatus,
      tenDayWeatherStatus);
}

Future<Address> retrieveLocationDetails(
    double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude, longitude,
        localeIdentifier: "en");

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      var result = Address(
        city: place.locality ?? '',
        countryName: place.country ?? '',
      );
      print("got the address: $result");
      return result;
    } else {
      print('No placemarks found');
      return Address();
    }
  } catch (e) {
    print('Error: $e');
    return Address();
  }
}

Future<WeatherStatus?> fetchWeatherStatus() async {
  // need to ask user to share their location
  // Position location;
  //
  // LocationPermission serviceEnabled = await Geolocator.checkPermission();
  // if (serviceEnabled == LocationPermission.denied) {
  //   serviceEnabled = await Geolocator.requestPermission();
  // }
  //
  // location = await Geolocator.getCurrentPosition();
  var location = [-1.972572, 30.125784];

  final statusRequest = await http.get(Uri(
      scheme: "https",
      host: "weather.visualcrossing.com",
      path: "VisualCrossingWebServices/rest/services/timeline/",
      queryParameters: {
        "key": "MDCQ6R9Z6U4NKDJD8JNXNWGR8",
        "lang": "en",
        "location": "${location[0]},${location[1]}",
        "date1": DateTime.now().toString(),
        "include": "days,hours,alerts,current",
        "options": "noheaders"
      }));

  if (statusRequest.statusCode == 200) {
    // print("the result: ${statusRequest.body}");
    var weatherStats =
        fromJson(jsonDecode(statusRequest.body) as Map<String, dynamic>);
    return weatherStats;
  }
  return null;
}

void main() {
  WeatherStatus? status;
  fetchWeatherStatus().then((value) => {
        if (value != null) {status = value}
      });

  print(status);
}
