import 'package:flutter/material.dart';
import 'package:voyage/pays-details.dart';
import 'meteo-details.dart';
import 'mydrawer.page.dart';
class Meteo extends StatelessWidget {
  TextEditingController txt_meteo = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Meteo'),
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_meteo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.sunny),
                      hintText: "KeyWord",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                  ),
                  onPressed: () {
                    _onGetGaleryDetails(context);
                  } ,
                  child: Text('chercher',style: TextStyle(fontSize: 22),),
                ),
              )
            ]
        )
    );
  }
  void _onGetGaleryDetails(BuildContext context) {
    String keyword=txt_meteo.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Meteodetails(keyword)));
    txt_meteo.text='';
  }
}


