import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/components/IrrigationList.dart';
import 'package:regapp/ui/components/WeatherCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true&hourly=temperature_2m,relativehumidity_2m,precipitation_probability'));
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

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    String greeting;

    if (currentHour < 12) {
      greeting = 'Bom dia';
    } else if (currentHour < 18) {
      greeting = 'Boa tarde';
    } else {
      greeting = 'Boa noite';
    }

    String? user = FirebaseAuth.instance.currentUser?.displayName;

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting, ${_capitalize(user!)}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: GestureDetector(
                onTap: () => context.push('/irrigations'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Próximas irrigações',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: IrrigationList(
                options: IrrigationOptions.all,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text('Clima agora',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: WeatherCard(
                  title: weatherNow['title']!,
                  rainPct: weatherNow['rainPct']!,
                  location: weatherNow['location']!),
            ),
          ],
        ),
      ),
    );
  }
}
