import 'package:flutter/material.dart';

class CitySearchBar extends StatefulWidget {
  const CitySearchBar({super.key});

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends State<CitySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // decoration: widget.currentTheme.containerDeco,
      child: SearchAnchor(
        isFullScreen: false,
        headerTextStyle: Theme.of(context).textTheme.bodyMedium,
        headerHintStyle: Theme.of(context).textTheme.bodyMedium,
        viewBackgroundColor: Colors.grey.shade900,
        viewShape: const BeveledRectangleBorder(),
        viewSide: const BorderSide(color: Colors.white),
        viewHintText: "search for a city",
        dividerColor: Colors.white,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            backgroundColor: MaterialStateProperty.all(
              Colors.grey.shade900,
            ),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 8.0)),
            hintText: "search for a city",
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              controller.openView();
            },
            trailing: const [
              Icon(
                Icons.search,
                size: 35,
                color: Colors.grey,
              )
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return [
            const ListTile(
              title: Text("LONDON GYAL"),
              textColor: Colors.white,
            ),
            const ListTile(
              title: Text("LONDON GYAL"),
              textColor: Colors.white,
            ),
            const ListTile(
              title: Text("LONDON GYAL"),
              textColor: Colors.white,
            )
          ];
        },
      ),
    );
  }
}
