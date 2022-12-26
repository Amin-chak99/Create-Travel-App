import 'package:flutter/material.dart';
import 'package:voyage/gallerie-details.dart';

import 'mydrawer.page.dart';
class Gallerie extends StatelessWidget {
  TextEditingController txt_gallery = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Gallerie'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_gallery,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.photo_library),
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
    String keyword=txt_gallery.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => GallerieDetails(keyword)));
    txt_gallery.text='';
  }
}


