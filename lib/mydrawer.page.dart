import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/notifier/config/global.params.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  late SharedPreferences prefs;


  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.white, Colors.blue])),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/4.jpg"),
                  radius: 80,
                ),
              ),

            ),
            ...(GlobalParams.menus as List).map((item){
              return ListTile(
                title : Text('${item['title']}',style: TextStyle(fontSize: 22),),
                leading:item['icon'],
                onTap: ()async{
                  if('${item['title']}'!="Déconnexion"){
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context,"${item['route']}");
                  }
                  else {
                   FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/authentification',
                            (Route<dynamic> route)=> false);
                  }
                },

              );


                  }
            )
            ]
        ),
    );
  }
}



