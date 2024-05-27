import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatefulWidget {
  BottomNavigationPage({
    super.key,
    required this.child,
    required this.state,
  });

  final StatefulNavigationShell child;
  GoRouterState state;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.state.topRoute?.name ?? 'Regapp'),
      ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(
            index,
            initialLocation: index == widget.child.currentIndex,
          );
          setState(() {});
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/plantIcon.svg',
              color: Colors.black, // Adjust the color as per your requirements
              width: 24, // Adjust the size as per your requirements
              height: 24,
            ),
            label: 'Plantas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracoes',
          ),
        ],
      ),
    );
  }
}
