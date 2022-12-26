
import 'package:flutter/material.dart';
import 'package:voyage/authentification.page.dart';
import 'package:voyage/gallerie.page.dart';
import 'package:voyage/home.page.dart';
import 'package:voyage/meteo.page.dart';
import 'package:voyage/parametre.page.dart';
import 'package:voyage/pays.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voyage/notifier/config/global.params.dart';
import 'firebase_options.dart';


import 'contact.page.dart';
import 'inscription.page.dart';
ThemeData theme = ThemeData.light();
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  options: DefaultFirebaseOptions.currentPlatform;

   await _onGetMode().then((value){
    GlobalParams.themeActuel.setMode(value);
    runApp(MyApp());
 });
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routers ={
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/contact': (context) => ContactPage(),


    '/gallerie': (context) => Gallerie(),
    '/meteo': (context) => Meteo(),
    '/parametre': (context) => ParametresPage(),
    '/pays': (context) => Pays(),




  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routers,
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
          if(snapshot.hasData)
            return HomePage();
          else
            return AuthentificationPage();
         }
      )
    );
  }
  @override
  void initState(){
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {

      });
    });
  }
}

Future<String> _onGetMode() async {
 final snapshot = await ref.child("mode" ).get();
 if (snapshot.exists)
   mode =snapshot.value.toString();
else
 mode = "Jour";
print(mode);
return (mode);
}


