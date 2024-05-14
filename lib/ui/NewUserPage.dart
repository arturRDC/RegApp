import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        const Color(0xFFF1F5EC),
        Theme.of(context).colorScheme.secondaryContainer
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Text(
                    'Bem vindo ao RegApp',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      height: 36 / 28,
                    ).copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Seu assistente pessoal para manter suas plantas felizes e saudáveis',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 24 / 16,
                      ).copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset('assets/images/plants_new_user.png')),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('Começar'))),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text('Ja tem uma conta? Login'))),
            ],
          ),
        ],
      ),
    ));
  }
}

// Text(
//           'Bem vindo ao RegApp',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w400,
//             fontSize: 28,
//             height: 36 / 28,
//           ).copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
//         ),
//         Text(
//           'Seu assistente pessoal para manter suas plantas felizes e saudáveis',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w400,
//             fontSize: 16,
//             height: 24 / 16,
//           ).copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
//         ),
