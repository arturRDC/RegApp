import 'package:flutter/material.dart';
import 'package:regapp/ui/components/IrrigationList.dart';

class AddPlantPage extends StatelessWidget {
  const AddPlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Adicionar Planta",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: const Center(
          child: Text("TODO: Adicionar Planta"),
        ));
  }
}
