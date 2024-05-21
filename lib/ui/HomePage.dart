import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Home',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ],
    );
  }
}
