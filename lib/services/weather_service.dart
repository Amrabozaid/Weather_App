import 'dart:convert';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "0143355463b34d3e99344157243009";

  Future<Weather?> getWeather(String city) async {
    final url = "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var ret_data = jsonDecode(response.body);
        return Weather.fromJson(ret_data);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
// 0143355463b34d3e99344157243009
// String url="http://api.weatherapi.com/v1/current.json?key=0143355463b34d3e99344157243009&q=London&aqi=no";