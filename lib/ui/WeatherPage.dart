import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:regapp/ui/components/WeatherCard.dart';
import 'package:regapp/ui/components/WeatherList.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int currentPageIndex = 0;
  Map<String, String> weatherNow = {
    'title': '',
    'location': '',
    'weekDay': '',
    'rainPct': ''
  };
  bool isLoading = true;

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

      print('lat: ${position.latitude} long: ${position.longitude}');
      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true&hourly=temperature_2m,relativehumidity_2m,precipitation_probability'));

      print('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherNow = {
            'title': getWeatherTitle(data['current_weather']['weathercode']),
            'location': locationName,
            'weekDay': DateTime.now().weekday.toString(),
            'rainPct':
                data['hourly']['precipitation_probability'][0].toString(),
          };
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hoje',
                      style: Theme.of(context).textTheme.headlineSmall),
                  WeatherCard(
                      title: weatherNow['title']!,
                      rainPct: weatherNow['rainPct']!,
                      location: weatherNow['location']!),
                  Text('Esta semana',
                      style: Theme.of(context).textTheme.headlineSmall),
                  WeatherList(),
                ],
              ),
      ),
    );
  }
}
