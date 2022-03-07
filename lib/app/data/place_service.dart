import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:perfect/app/models/place.dart';

// class Place {
// late  String streetNumber;
// late  String street;
// late  String city;
// late  String zipCode;
//   //
//   // Place({
//   //   this.streetNumber,
//   //   this.street,
//   //   this.city,
//   //   this.zipCode,
//   // });
//
//   @override
//   String toString() {
//     return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
//   }
// }
// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyAcEmcdHwSqGIsvyjsSY6t5n79Kpb33CbQ';
  static final String iosKey = 'AIzaSyAcEmcdHwSqGIsvyjsSY6t5n79Kpb33CbQ';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<dynamic>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  // Future<Place> getPlaceDetailFromId(String placeId) async {
  //   print("PLACE ID :: ${placeId}");
  //   final request =
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
  //   final response = await client.get(Uri.parse(request));
  //   print("RESPONSE :::: ${response}");
  //   print(response.statusCode);
  //   if(response.statusCode == 200){
  //     var jsonResponse  = jsonDecode(response.body);
  //     print(jsonResponse);
  //
  //     return Place.fromJson(jsonResponse);
  //   }
  //
  //   if (response.statusCode == 200) {
  //     final result = json.decode(response.body);
  //     if (result['status'] == 'OK') {
  //       final components =
  //       result['result'] as List<Place>;
  //       // build result
  //       final place = Place();
  //       print(result['result']);
  //       components.forEach((c) {
  //         final List type = c['geometry'];
  //         if(type.contains('location')){
  //           place.geometry!.location!.lat = c['geometry']['location']['lat'];
  //         // if (type.contains('street_number')) {
  //         //   place.addressComponents!.first.longName = c['long_name'];
  //         // }
  //         // if (type.contains('route')) {
  //         //   place.street = c['long_name'];
  //         // }
  //         // if (type.contains('locality')) {
  //         //   place.city = c['long_name'];
  //         // }
  //         // if (type.contains('postal_code')) {
  //         //   place.zipCode = c['long_name'];
  //         }
  //       });
  //       return place;
  //     }
  //     throw Exception(result['error_message']);
  //   }
  //   else {
  //     throw Exception('Failed to fetch suggestion');
  //   }
  // }
  //
  }
  // Future<Place> getPlaceDetailFromId(String placeId) async {
  //   // if you want to get the details of the selected place by place_id
  // }
// }