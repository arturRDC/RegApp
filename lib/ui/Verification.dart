import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Redefinir Senha')),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.eco,
                    size: 120, color: Theme.of(context).colorScheme.primary),
                Text("Código de acesso"),
                Align(
                  alignment: Alignment.center,
                  child: VerificationCode(
                  textStyle: TextStyle(fontSize: 20.0),
                  keyboardType: TextInputType.number,
                  underlineColor: Colors
                      .amber, // If this is null it will use primaryColor: Colors.red from Theme
                  length: 6,
                  cursorColor: Theme.of(context).colorScheme.primary, // If this is null it will default to the ambient
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Limpar',
                      style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.underline, decorationColor: const Color.fromRGBO(75, 119, 30, 1),
                          color: Color.fromRGBO(75, 119, 30, 1)),
                    ),
                  ),
                  onCompleted: (String value) {
                    setState(() {
                      //_code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      //_onEditing = value;
                    });
                    //if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: const Text(
                        "Confirmar",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
