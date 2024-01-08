import 'package:flutter/material.dart';
import 'package:weather_app_ui/cards/city_card.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/pages/city_search_bar.dart';

class CitySearchWidget extends StatefulWidget {
  const CitySearchWidget({super.key, required this.currentTheme});
  final ColorThemeSetter currentTheme;

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              "WEATHER",
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30),
            ),
          ),
          const CitySearchBar(),
          Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Column(
                children: [
                  CityCard(location: "Kigali Rwanda"),
                ],
              ))
        ],
      ),
    );
  }
}
