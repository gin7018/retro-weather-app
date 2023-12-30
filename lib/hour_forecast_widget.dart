import 'package:flutter/material.dart';
import 'package:weather_app_ui/weather_data_provider.dart';

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
    return Expanded(
        child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: widget.forecasts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text("${widget.forecasts[index].date.hour}"),
            const Icon(Icons.cloud),
            Text("${widget.forecasts[index].temperature}"),
          ],
        );
      },
      separatorBuilder: ((context, index) => const SizedBox(
            width: 20,
          )),
    ));
  }
}
