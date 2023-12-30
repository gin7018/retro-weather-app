import 'package:flutter/material.dart';
import 'package:weather_app_ui/weather_data_provider.dart';

class DaysForeCastWidget extends StatefulWidget {
  final List<ForeCast> d10Forecasts;

  const DaysForeCastWidget({super.key, required this.d10Forecasts});

  @override
  State<DaysForeCastWidget> createState() => DaysForeCastWidgetState();
}

class DaysForeCastWidgetState extends State<DaysForeCastWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
