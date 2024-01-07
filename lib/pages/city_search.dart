import 'package:flutter/material.dart';
import 'package:weather_app_ui/misc/styles.dart';

class CitySearchWidget extends StatefulWidget {
  const CitySearchWidget({super.key, required this.currentTheme});
  final ColorThemeSetter currentTheme;

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
