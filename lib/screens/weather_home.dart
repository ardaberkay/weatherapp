import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/components/weather_detail.dart';
import 'package:weatherapp/services/weather_service.dart';
import '../models/weather_data.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late WeatherData weatherInfo;
  bool isLoading = false;

  myWeather() {
    WeatherService().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    weatherInfo = WeatherData(
        name: '',
        temperature: Temperature(current: 0.0),
        humidity: 0,
        wind: Wind(speed: 0.0),
        maxTemperature: 0,
        minTemperature: 0,
        pressure: 0,
        seaLevel: 0,
        weather: []
    );
    myWeather();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE D, MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isLoading ?
              WeatherDetail(
                weather: weatherInfo,
                formattedDate: formattedDate,
                formattedTime: formattedTime,
              ) : const CircularProgressIndicator(color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
