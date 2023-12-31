import 'package:flutter/material.dart';
import 'package:weather_app_ui/weather_data_provider.dart';
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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(DateFormat('EEEE')
                      .format(widget.d10Forecasts[index].date)
                      .substring(0, 3)),
                  const Icon(Icons.cloud),
                  Text("${widget.d10Forecasts[index].low}"),
                  const Icon(Icons.arrow_forward_outlined),
                  Text("${widget.d10Forecasts[index].high}"),
                ],
              ),
            ),
        itemCount: widget.d10Forecasts.length);
  }
}
