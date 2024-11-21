import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_data.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail(
      {super.key,
      required this.weather,
      required this.formattedDate,
      required this.formattedTime});

  String getWeatherAnimation(List<WeatherInfo> weather) {
    if (weather.isEmpty) {
      return 'assets/sunny.json';
    }
    for (var info in weather) {
      switch (info.main.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloud.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/rainy.json';
        case 'thunderstorm':
          return 'assets/thunder.json';
        case 'clear':
          return 'assets/sunny.json';
      }
    }
    return 'assets/sunny.json';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}°C",
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        const SizedBox(height: 30),
        Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Lottie.asset(getWeatherAnimation(weather.weather)),
        ),
        const SizedBox(width: 30),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Wind", value: "${weather.wind.speed}km/h")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Max",
                            value:
                                "${weather.maxTemperature.toStringAsFixed(2)}°C")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny_snowing,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Min",
                            value:
                                "${weather.minTemperature.toStringAsFixed(2)}°C")
                      ],
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Humidity", value: "${weather.humidity}km/h")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.air,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Pressure", value: "${weather.pressure}hPa")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.leaderboard,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        weatherInfoCard(
                            title: "Sea-Level", value: "${weather.seaLevel}m")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column weatherInfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
