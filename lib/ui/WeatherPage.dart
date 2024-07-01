import 'package:flutter/material.dart';
import 'package:regapp/ui/components/WeatherCard.dart';
import 'package:regapp/ui/components/WeatherList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:regapp/models/Weather.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  Weather weather = Weather(weather: "", temperature: "", rainPct: "");

  late String lat;
  late String long;

  Future <Position> _getCurrentLocation() async {
    bool serviceEnaled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnaled) {
      return Future.error('Serviços de localização estão desabiilitados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões de localização estão permanentemente negadas, incapaz de solicitar.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getWeather() async{
    _getCurrentLocation().then((value) {
      lat = '${value.latitude}';
      long = '${value.longitude}';
    });
    var response = await http.get(Uri.https('api.open-meteo.com', 'v1/forecast?latitude=' + lat + '&longitude=' + long + '&current=temperature_2m,weather_code&daily=precipitation_probability_max&forecast_days=1'));
    var jsonData = jsonDecode(response.body);
    var currentWeather = jsonData['current'];
    var dailyWeather = jsonData['daily'];
    weather = Weather(weather: currentWeather['weather_code'], temperature: currentWeather['temperature_2m'], rainPct: dailyWeather['precipitation_probability_max']);
  }
  
  int currentPageIndex = 0;
  final Map<String, String> weatherNow = {
    'title': 'Ensolarado',
    'location': 'Natal - RN',
    'weekDay': 'Segunda',
    'rainPct': '15'
  };
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder(
          future: getWeather(),
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hoje', style: Theme.of(context).textTheme.headlineSmall),
            WeatherCard(
                title: weatherNow['title']!,
                rainPct: weatherNow[weather.rainPct]!,
                location: weatherNow['location']!),
            Text('Esta semana',
                style: Theme.of(context).textTheme.headlineSmall),
            WeatherList(),
          ],
        );
            }
            else {
              return Center(child: CircularProgressIndicator(),);
            }
            throw Exception();
          },
          
        )
      ),
    );
  }
}
