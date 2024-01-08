import 'package:flutter/material.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/pages/city_search.dart';
import 'package:weather_app_ui/pages/weather_widget.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // fontFamily: 'IBM Plex Mono',
          fontFamily: "Retro Gaming",
          textTheme: const TextTheme().copyWith(
            bodySmall: const TextStyle(color: Colors.white),
            bodyMedium: const TextStyle(color: Colors.white),
            bodyLarge: const TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      home: const WeatherAppNavigator(),
    );
  }
}

class WeatherAppNavigator extends StatefulWidget {
  const WeatherAppNavigator({super.key});

  @override
  State<WeatherAppNavigator> createState() => _WeatherAppNavigatorState();
}

class _WeatherAppNavigatorState extends State<WeatherAppNavigator> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        indicatorColor: Colors.black,
        height: 60,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.location_on_sharp,
                color: Colors.white,
                size: 30,
              ),
              label: ""),
          NavigationDestination(
              icon: Icon(
                Icons.view_list,
                color: Colors.white,
                size: 40,
              ),
              label: "")
        ],
      ),
      body: [const WeatherWidget(), const CitySearchWidget()][currentPageIndex],
    );
  }
}
