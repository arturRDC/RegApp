import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:regapp/models/Weather.dart';
import 'package:regapp/ui/components/WeatherCard.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({super.key});

  @override
  State<WeatherList> createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  bool isLoading = true;
  List<Weather> weatherWeek = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<String> getLocationName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark placemark = placemarks[0];

    String locationName =
        '${placemark.subAdministrativeArea!} - ${placemark.isoCountryCode!}';
    return locationName;
  }

  Future<void> fetchWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      String locationName = await getLocationName(position);

      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&daily=weather_code,precipitation_probability_max&timezone=America%2FSao_Paulo'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Weather> newWeatherWeek = [];
        for (var i = 0; i < 7; i++) {
          int code = data['daily']['weather_code'][i];
          int rain = data['daily']['precipitation_probability_max'][i];
          String weatherStr = getWeatherTitle(code);
          newWeatherWeek.add(Weather(
              weather: weatherStr,
              rainPct: rain.toString(),
              location: locationName));
        }
        setState(() {
          weatherWeek = newWeatherWeek;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String getWeatherTitle(int weatherCode) {
    if (weatherCode == 0 || weatherCode == 1) {
      return 'Ensolarado';
    } else if (weatherCode < 50) {
      return 'Nublado';
    } else {
      return 'Chuvoso';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (weatherWeek.isEmpty) {
      return const Center(child: Text('Failed to load weather data'));
    } else {
      return ListView(
        shrinkWrap: true,
        children: _buildPlantCards(),
      );
    }
  }

  List<Widget> _buildPlantCards() {
    List<Widget> weatherCards = [];

    for (var weather in weatherWeek) {
      weatherCards.add(
        WeatherCard(
          title: weather.weather,
          rainPct: weather.rainPct,
          // todo add weekday
          // weekDay: weather['weekDay']!,
          location: weather.location,
        ),
      );
      weatherCards.add(const SizedBox(height: 8));
    }

    return weatherCards;
  }
}
