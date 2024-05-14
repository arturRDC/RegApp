import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Criar Conta')
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[const Color(0xFFF1F5EC), Theme.of(context).colorScheme.secondaryContainer]),
          )
      )
    );
  }
}