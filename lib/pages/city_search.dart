import 'package:flutter/material.dart';
import 'package:weather_app_ui/cards/city_card.dart';
import 'package:weather_app_ui/main.dart';
import 'package:weather_app_ui/pages/city_search_bar.dart';
import 'package:get_storage/get_storage.dart';

class CitySearchWidget extends StatefulWidget {
  const CitySearchWidget({super.key});

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

List<dynamic> getBookmarkedCities() {
  final box = GetStorage();
  return box.read("bookmarked-cities") ?? [];
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  List<dynamic> bookmarkedCities = getBookmarkedCities();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      color: Colors.black,
      height: double.infinity,
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 30,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: bookmarkedCities.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherAppNavigator(
                                  startingPageIndex: 0,
                                  defaultCity: bookmarkedCities[index],
                                ),
                              )),
                          child: CityCard(location: bookmarkedCities[index]));
                    },
                    separatorBuilder: ((context, index) => const SizedBox(
                          height: 20,
                        )),
                  ),
                ),
              ),
              const CitySearchBar(),
            ],
          )
        ],
      ),
    );
  }
}
