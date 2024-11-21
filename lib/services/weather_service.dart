import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=41.01384&lon=28.94966&appid=26acef7ef08486be4839f9c549b6dedf"),
    );
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
