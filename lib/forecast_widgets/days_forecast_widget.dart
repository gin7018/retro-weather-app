import 'package:flutter/material.dart';
import 'package:weather_app_ui/data_provider/weather_data_provider.dart';
import 'package:intl/intl.dart';

class DaysForeCastWidget extends StatefulWidget {
  final List<ForeCast> d10Forecasts;

  const DaysForeCastWidget({super.key, required this.d10Forecasts});

  @override
  State<DaysForeCastWidget> createState() => DaysForeCastWidgetState();
}

class DaysForeCastWidgetState extends State<DaysForeCastWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateFormat('EEEE')
                      .format(widget.d10Forecasts[index].date)
                      .substring(0, 3)),
                  Image.asset(
                    "assets/3rd-set-color-weather-icons/${widget.d10Forecasts[index].icon}.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  Text("${widget.d10Forecasts[index].low?.round()}°"),
                  const Text("/"),
                  Text("${widget.d10Forecasts[index].high?.round()}°"),
                ],
              ),
            ),
        itemCount: widget.d10Forecasts.length);
  }
}
