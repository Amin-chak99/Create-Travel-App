import 'package:flutter/material.dart';

import 'package:voyage/pays-details.dart';

import 'mydrawer.page.dart';
class Pays extends StatelessWidget {
  TextEditingController txt_pays = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Pays'),
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: txt_pays,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_rounded),
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
    String keyword=txt_pays.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => paysDetails(keyword)));
    txt_pays.text='';
  }
}


