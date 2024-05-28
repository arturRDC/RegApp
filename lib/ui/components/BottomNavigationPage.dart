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
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFF416C49),
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: Color(0xFFF6FCF8),
                )),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.wb_sunny_outlined, color: Color(0xFF1C1B1F)),
            activeIcon: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFF416C49),
                ),
                child: const Icon(
                  Icons.wb_sunny_outlined,
                  color: Color(0xFFF6FCF8),
                )),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/plantIcon.svg',
              color: const Color(
                  0xFF1C1B1F), // Adjust the color as per your requirements
              width: 24, // Adjust the size as per your requirements
              height: 24,
            ),
            activeIcon: Container(
              width: 64,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: const Color(0xFF416C49),
              ),
              child: SvgPicture.asset(
                'assets/icons/plantIcon.svg',
                color: const Color(
                    0xFFF6FCF8), // Adjust the color as per your requirements
                width: 24, // Adjust the size as per your requirements
                height: 24,
              ),
            ),
            label: 'Plantas',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF1C1B1F)),
            activeIcon: Container(
                width: 64,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFF416C49),
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFFF6FCF8),
                )),
            label: 'Configuracoes',
          ),
        ],
      ),
    );
  }
}
