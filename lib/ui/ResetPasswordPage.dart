import 'package:flutter/material.dart';
import 'package:regapp/ui/Verification.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Resetar senha')),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.eco,
                    size: 120, color: Theme.of(context).colorScheme.primary),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
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
                        "Enviar código de acesso",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Verification()));
                  },
                  child: Text(
                    'Eu tenho um código de acesso',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color.fromRGBO(75, 119, 30, 1),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color.fromRGBO(75, 119, 30, 1),
                          decorationThickness: 2,
                        ),
                  ),
                ),
              ],
            ))));
  }
}
