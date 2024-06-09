import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Esqueci minha senha')
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
                
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonTheme(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                      child: const Text(
                        "Enviar código de acesso",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),),
                ),
                
                TextButton(
                        onPressed: () {
                        
                            
                      },
                        child: Text(
                          'Eu tenho um código de acesso',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color.fromRGBO(75, 119, 30, 1),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline, decorationColor: const Color.fromRGBO(75, 119, 30, 1),
                                    decorationThickness: 2,
                                  ),
                        ),
                      ),

              ],
            )
        )
      )
    );
  }
}