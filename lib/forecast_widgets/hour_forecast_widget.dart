import 'package:flutter/material.dart';
import 'package:weather_app_ui/data_provider/weather_data_provider.dart';

class HourForecastWidget extends StatefulWidget {
  final List<ForeCast> forecasts;

  const HourForecastWidget({
    super.key,
    required this.forecasts,
  });

  @override
  State<StatefulWidget> createState() => HourForecastWidgetState();
}

class HourForecastWidgetState extends State<HourForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.forecasts.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (widget.forecasts[index].date.hour > 12)
                  Text("${widget.forecasts[index].date.hour % 12} PM")
                else
                  Text("${widget.forecasts[index].date.hour} AM"),
                Image.asset(
                  "assets/3rd-set-color-weather-icons/${widget.forecasts[index].icon}.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Text("${widget.forecasts[index].temperature.round()}°"),
              ],
            );
          },
          separatorBuilder: ((context, index) => const SizedBox(
                width: 40,
              )),
        ));
  }
}
