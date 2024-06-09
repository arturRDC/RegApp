import 'package:flutter/material.dart';
import 'package:regapp/ui/LoginPage.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Nova senha')
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.mark_email_read_outlined, size: 120, color: Theme.of(context).colorScheme.primary),
                Text("Email validado com sucesso!"),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Nova senha",
                    labelStyle: TextStyle(color:Theme.of(context).colorScheme.primary),                  
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color:Theme.of(context).colorScheme.primary),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Confirmar senha",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                      child: const Text(
                        "Redefinir senha",
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