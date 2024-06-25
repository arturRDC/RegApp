import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/LoginPage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Criar Conta')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SizedBox(
              height: MediaQuery.of(context).size.height - 153,
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      'assets/images/regAppLogo.png',
                      width: 112,
                      height: 153,
                    ),
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Primeiro Nome",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Nome de usuário",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordConfirmationController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Confirmar Senha",
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: Text(
                          'Já tenho uma conta',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color.fromRGBO(75, 119, 30, 1),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        const Color.fromRGBO(75, 119, 30, 1),
                                    decorationThickness: 2,
                                  ),
                        ),
                      ),
                      ButtonTheme(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _registerUser(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          child: const Text(
                            "Realizar Cadastro",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
        ));
  }

  void _registerUser(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String firstName = _firstNameController.text.trim();
    String username = _usernameController.text.trim();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateProfile(displayName: firstName);

        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
        });

        if (context.mounted) {
          context.go('/home');
        }
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
