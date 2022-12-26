import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class paysDetails extends StatefulWidget {
  String keyword='';
  paysDetails(this.keyword);


  @override
  State<paysDetails> createState() => _paysDetailsState();
}


class _paysDetailsState extends State<paysDetails> {

  var paysData;
void initState(){
  super.initState();
  getpaysData(widget.keyword);
}
  void getpaysData(String keyword) {
    print("Details pays de"+ keyword);
    String url=
        "https://restcountries.com/v2/name/${keyword}";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
    this.paysData= json.decode (utf8.decode(resp.bodyBytes));

        print(this.paysData);
      });
    }).catchError((err){
      print(err);
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Pays page details ${widget.keyword}'),
    ),
      body: (paysData == null
          ? Center(child: CircularProgressIndicator())
          :Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child:  Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Image.network(paysData[0]['flags']['png'])

                  ),
                ],
              ),
            ),
            Container(

              child: Text(
                '${paysData[0]['name']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,

                ),

              ),
            ),
            Container(
              child: Text(
                paysData[0]['nativeName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,

                  fontSize: 22,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),

              child: Text(

                'Administration',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue
                ),
              ),
            ),
            Container(
              child: Text('Capital :${paysData[0]['capital']}',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Container(
                child:Text('Langage : ${paysData[0]['languages'][0]['name']}, ${paysData[0]['languages'][0]['nativeName']}  ',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),

              child: Text(
                'Géographie',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue
                ),
              ),
            ),
            Container(
              child:Text('Région : ${paysData[0]['region']}',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              child:Text('Superficie : ${paysData[0]['area']}',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              child:Text('Fuseau Horaire : ${paysData[0]['timezones'][0]}',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Démographie',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue
                ),
              ),
            ),
            Container(
              child:Text('Population : ${paysData[0]['population']}',
                style: TextStyle(
                  fontSize: 22,
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
