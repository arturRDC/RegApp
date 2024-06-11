import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/CreateAccountPage.dart';
import 'package:regapp/ui/ResetPasswordPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
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
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não possui conta?',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color.fromRGBO(75, 119, 30, 1),
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateAccount()));
                      },
                      child: Text(
                        'Criar conta',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color.fromRGBO(75, 119, 30, 1),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  const Color.fromRGBO(75, 119, 30, 1),
                              decorationThickness: 2,
                            ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()));
                  },
                  child: Text(
                    'Esqueci minha senha',
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
