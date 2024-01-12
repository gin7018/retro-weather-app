import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_app_ui/cards/styles.dart';
import 'package:weather_app_ui/data_provider/places_autocompleter.dart';
import 'package:searchfield/searchfield.dart';
import 'package:weather_app_ui/main.dart';

class CitySearchBar extends StatefulWidget {
  const CitySearchBar({super.key});

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends State<CitySearchBar> {
  List<String> suggestedCities = [];
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showSearchView = false;

  Future<void> fetchSuggestions(String query) async {
    var sessionToken = const Uuid().v4();
    var result = await autocompletePlaces(query, sessionToken);
    setState(() {
      suggestedCities = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: searchDecoration,
        child: Column(children: [
          TextField(
              controller: textController,
              focusNode: focusNode,
              showCursor: true,
              cursorColor: Colors.white,
              onTap: (() => setState(() {
                    showSearchView = true;
                  })),
              onChanged: (query) async {
                showSearchView = true;
                await fetchSuggestions(query);
              },
              decoration: InputDecoration(
                hintText: 'search city',
                prefixIcon: showSearchView
                    ? IconButton(
                        onPressed: (() {
                          setState(() {
                            showSearchView = false;
                            suggestedCities.clear();
                            focusNode.unfocus();
                          });
                        }),
                        icon: const Icon(Icons.arrow_back))
                    : const Icon(
                        Icons.search,
                      ),
                suffixIcon: showSearchView
                    ? IconButton(
                        onPressed: (() {
                          setState(() {
                            suggestedCities.clear();
                          });
                          textController.clear();
                        }),
                        icon: const Icon(Icons.cancel))
                    : null,
                iconColor: Colors.white,
              )),
          if (showSearchView == true)
            SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: suggestedCities.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(suggestedCities[index]),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherAppNavigator(
                              startingPageIndex: 0,
                              defaultCity: suggestedCities[index],
                            ),
                          )),
                    );
                  }),
                ))
        ]));
  }
}
