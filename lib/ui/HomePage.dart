import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regapp/router/CustomNavigationHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bom dia, ' 'User',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Próximas irrigações',
                    style: Theme.of(context).textTheme.headlineSmall),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          // Add the Listview here
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            children: const [
              Card(
                child: Text('irrig1'),
              ),
              Text('testItem1'),
              Text('testItem2'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text('Clima agora',
                style: Theme.of(context).textTheme.headlineSmall),
          )
        ],
      ),
    );
  }
}
