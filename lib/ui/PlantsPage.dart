import 'package:flutter/material.dart';
import 'package:regapp/ui/components/IrrigationList.dart';
import 'package:regapp/ui/components/PlantList.dart';
import 'package:regapp/ui/components/WeatherCard.dart';
import 'package:regapp/ui/components/WeatherList.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({super.key});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PlantList(),
      ),
    );
  }
}
