import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentification.page.dart';

import 'home.page.dart';
class InscriptionPage extends StatelessWidget {
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Page Inscription')),
        body: Center(


            child: Column(

            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5 , left: 10 , right: 10),
                child: TextFormField(
                  controller: txt_login,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),

                    hintText: "Identifiant ",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    labelText: "Identifiant",
                  ),
                  obscureText: false,
                  maxLength: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                      suffixIcon: Icon(
                        Icons.visibility,),
                    hintText: "Mot de Passe",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    labelText: "mot de passe",
                  ),

                  obscureText: true,
                  maxLength: 10,
                ),
              ),

              TextButton(
                onPressed: () {
                  _onInscrire(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 63, 95, 169)),
                  foregroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 252, 252, 252)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                          horizontal: 120.10, vertical: 10.1)),
                ),
                child: Text(
                  "Inscription",
                  style: TextStyle(

                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
               child:  TextButton(
                 onPressed: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => AuthentificationPage(),
                       ));
                 },
                 style: ButtonStyle(
                   foregroundColor: MaterialStateProperty.all(
                       Color.fromARGB(255, 63, 95, 169)),
                   padding: MaterialStateProperty.all(
                       EdgeInsets.symmetric(horizontal: 80.10)),
                 ),
                 child: Text(
                   "J'ai deja un compte",
                   style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
              )
            ])
        )
    );
  }
  Future<void> _onInscrire(BuildContext context) async {
    if (!txt_login.text.isEmpty && !txt_password.text.isEmpty){
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: txt_login.text.trim(), password: txt_password.text.trim());
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      }
     on FirebaseAuthException catch(e){
        SnackBar snackBar= SnackBar(
            content: Text(""));
        if (e.code == 'weak-password'){
          snackBar =SnackBar(content: Text("Mot de passe faible"));
        }else if (e.code == 'email-already-in-use'){
          snackBar =SnackBar(content: Text("Email déja existant"));
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }

    }
    else{
      const snackBar = SnackBar(content: Text('ID ou Mot de passe vide'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}

