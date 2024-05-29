import 'package:flutter/material.dart';
import 'package:regapp/ui/components/IrrigationList.dart';

class IrrigationsPage extends StatelessWidget {
  const IrrigationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Irrigações"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hoje', style: Theme.of(context).textTheme.headlineSmall),
              IrrigationList(),
              Text('Proximas',
                  style: Theme.of(context).textTheme.headlineSmall),
              IrrigationList(),
            ],
          ),
        ),
      ),
    );
  }
}
