import 'package:flutter/material.dart';
import 'package:regapp/ui/LoginPage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

/*appBar: AppBar(
      title: const Text('Criar Conta')
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[const Color(0xFFF1F5EC), Theme.of(context).colorScheme.secondaryContainer]),
          )
      )*/

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Criar Conta')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
              alignment: Alignment.center,
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      'assets/images/regAppLogo.png',
                      width: 112,
                      height: 153,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Primeiro Nome",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nome de usuário",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Confirmar Senha",
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Text(
                      'Já tenho uma conta',
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
                  //SizedBox(height: 200),
                  ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
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
              ))),
        ));
  }
}
