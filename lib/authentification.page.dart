import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.page.dart';
import 'inscription.page.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs ;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Page Authentification')),
        body: Center(

            child: Column(

                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 5 , left: 10 , right: 10),
                    child: TextField(
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
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      maxLength: 50,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: txt_password,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: Icon(
                          Icons.visibility,
                        ),
                        hintText: "Mot de Passe",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        labelText: "mot de passe",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      maxLength: 50,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      _onAuthentifier(context);
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
                      "Connexion",
                      style: TextStyle(
                        fontFamily: 'Aboret',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                   TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InscriptionPage(),
                            ));
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 63, 95, 169)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 80.10)),
                      ),
                      child: Text(
                        "Nouvel Utilisateur",
                        style: TextStyle(
                          fontFamily: 'Aboret',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                  )
                ]
            )
        )

    );
  }
  Future<void> _onAuthentifier (BuildContext context) async
  {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: txt_login.text.trim(), password: txt_password.text.trim());
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    }on FirebaseAuthException catch(e){
      SnackBar snackBar = SnackBar(content: Text(""));
      if(e.code == 'user-not-found'){
        snackBar = SnackBar(content: Text('Utilisateur inexistant'),);
      }else if (e.code =='wrong-password'){
        snackBar = SnackBar(content: Text('Verifier votre mot de passe'));
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }
}