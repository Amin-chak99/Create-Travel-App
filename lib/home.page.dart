import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mydrawer.page.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
        drawer:MyDrawer(),
        appBar: AppBar(title: Text('Page Home')),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Utilisateur: ${user?.email}",style: TextStyle(fontSize: 22),),
            ),
            Center(
                child:Wrap(
                  children: [
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('assets/images/meteo.png'),

                      ),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/meteo');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('assets/images/gallerie.png')),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/gallerie');

                      },
                    ),
                    InkWell(
                      child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('assets/images/pays.png')),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/pays');

                      },
                    ),
                    InkWell(
                      child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('assets/images/contact.png')),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/contact');

                      },
                    ),
                    InkWell(
                      child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('assets/images/parametres.png')),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/parametre');

                      },
                    ),
                    InkWell(
                      child: Ink.image(
                          height: 180,
                          width: 180,
                          image: AssetImage('assets/images/deconnexion.png')),
                      onTap: (){
                        _Deconnexion(context);

                      },
                    ),
                  ],
                )
            )
          ],
        )


        );
  }

  Future<void> _Deconnexion(context) async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/authentification',
            (Route<dynamic> route)=> false);
  }

}