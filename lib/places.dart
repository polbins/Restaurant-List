import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:tech_tuesday_demo/key.dart';

class Place {
  final String name;
  final double rating;
  final String address;

  Place.fromJson(Map jsonMap)
      : name = jsonMap['name'],
        rating = jsonMap['rating']?.toDouble() ?? -1.0,
        address = jsonMap['vicinity'];

  String toString() => 'Place: $name';
}

getPlaces(double lat, double lng) async {
  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$lat,$lng'
      '&radius=500'
      '&type=restaurant'
      '&key=$PLACES_API_KEY';

//  http.get(url).then((res) => print(res.body));

  var client = http.Client();
  var streamedRes = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as Map)['results'])
      .map((jsonPlace) => Place.fromJson(jsonPlace)); // end here
//      .listen((data) => print(data))
//      .onDone(() => client.close());
}
