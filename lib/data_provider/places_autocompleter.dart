import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> autocompletePlaces(
    String query, String sessionToken) async {
  String apiKey = ""; // TODO
  final autocompleteRequest =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=administrative_area_level_1&language=en&types=cities&key=$apiKey&sessiontoken=$sessionToken';
  final response = await http.get(Uri.parse(autocompleteRequest));

  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    var suggestions = (result["predictions"] as List<dynamic>)
        .map<String>((suggestion) => suggestion["description"])
        .toList();
    print("==== got ${suggestions.length} suggestions");
    return suggestions;
  }
  return [];
}
