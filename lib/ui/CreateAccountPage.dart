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
      appBar: AppBar(
      title: const Text('Criar Conta')
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.eco, size: 120, color: Theme.of(context).colorScheme.primary),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color:Theme.of(context).colorScheme.primary),                  
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Theme.of(context).colorScheme.primary),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    labelStyle: TextStyle(color:Theme.of(context).colorScheme.primary),                  
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Theme.of(context).colorScheme.primary),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color:Theme.of(context).colorScheme.primary),                  
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Theme.of(context).colorScheme.primary),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Confirmar Senha",
                    labelStyle: TextStyle(color:Theme.of(context).colorScheme.primary),                  
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Theme.of(context).colorScheme.primary),
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
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Color.fromRGBO(75, 119, 30, 1),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                  ),
                        ),
                      ),
                

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                      child: const Text(
                        "Realizar Cadastro",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),),
                ),
              ],
            )
        )
      )
    );
  }
}