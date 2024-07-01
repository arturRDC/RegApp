import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  Map<String, String> weatherToday = {
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

      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&daily=weather_code,precipitation_probability_max&timezone=America%2FSao_Paulo'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherToday = {
            'title': getWeatherTitle(data['daily']['weather_code'][0]),
            'location': locationName,
            'weekDay': DateTime.now().weekday.toString(),
            'rainPct':
                data['daily']['precipitation_probability_max'][0].toString(),
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
            ? const Center(
                child: SpinKitDualRing(
                color: Colors.green,
                size: 50.0,
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hoje',
                      style: Theme.of(context).textTheme.headlineSmall),
                  WeatherCard(
                      title: weatherToday['title']!,
                      rainPct: weatherToday['rainPct']!,
                      location: weatherToday['location']!),
                  Text('Esta semana',
                      style: Theme.of(context).textTheme.headlineSmall),
                  WeatherList(),
                ],
              ),
      ),
    );
  }
}
