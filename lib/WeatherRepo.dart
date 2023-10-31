import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

class WeatherRepo {
  final String apiKey = '9109f3e72442fea157516dccfeab9910'; // Store your API key securely

  WeatherRepo();

  Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiKey");
    final headers = {
      'Content-Type': 'application/json',
      // Include authentication token in the headers if required by the API
      // 'Authorization': 'Bearer YOUR_AUTH_TOKEN',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception();
    }

    return parsedJson(response.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);
    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}

class LocationBasedFeatures {
  Future<List<Map<String, dynamic>>> getLocations(
      String city, String stateCode, String countryCode, int limit, String apiKey) async {
    final result = await http.Client().get(Uri.parse(
        "http://api.openweathermap.org/geo/1.0/direct?q=$city,$stateCode,$countryCode&limit=$limit&appid=$apiKey"));

    if (result.statusCode != 200) {
      throw Exception();
    }

    final jsonDecoded = json.decode(result.body);
    return List<Map<String, dynamic>>.from(jsonDecoded);
  }
}