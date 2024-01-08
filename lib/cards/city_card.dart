import 'package:flutter/material.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/data_provider/weather_data_provider.dart';

class CityCard extends StatefulWidget {
  const CityCard({super.key, required this.location});
  final String location;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  late WeatherStatus cityWeatherStatus;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initializeWeatherStatus() async {
    cityWeatherStatus = (await fetchWeatherStatus(widget.location))!;
    print("the statusssss ${cityWeatherStatus.toString()}");
  }

  String formatTime(DateTime date) {
    var hour = "${date.hour % 12}";
    var minutes = "${date.minute}";
    var whichHalfOfDay = "AM";

    if (date.minute < 10) {
      minutes = "0$minutes";
    }
    if (date.hour >= 12) {
      whichHalfOfDay = "PM";
    }
    if (date.hour == 12) {
      hour = "12";
    }
    return "$hour:$minutes $whichHalfOfDay";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeWeatherStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: LinearProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
            );
          } else {
            return Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration:
                  getContainerDeco(cityWeatherStatus.h24Forecast[0].date),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cityWeatherStatus.cityLocation,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          formatTime(cityWeatherStatus.h24Forecast[0].date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        cityWeatherStatus.weatherDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${cityWeatherStatus.currentTemperature.round()}°",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 40),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}
