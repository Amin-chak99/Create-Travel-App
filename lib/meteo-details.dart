import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Meteodetails extends StatefulWidget {
  String keyword='';
  Meteodetails(this.keyword);


  @override
  State<Meteodetails> createState() => _MeteodetailsState();

}

class _MeteodetailsState extends State<Meteodetails> {
  var MeteoData;
  var MeteoDataTun ;
  List<dynamic> Five= [] ;
  List<dynamic> fat= [] ;

  List<String> fa= [] ;
  List<dynamic> la=[];
  List<FiveDayData> Liste=[];

  void load(){
    for (var i=0 ;i<fa.length;i++){
      Liste.add(FiveDayData(fa[i],la[i]));

    }
  }

  List<String> cities = [
    'Tunis',
    'Mahdia',
    'Gafsa',
    'Djerba',
    'Sousse',
    'Paris',
    'Rome',
    'Alger'
  ];

  var datalist=[];
  var ForecastMeteoData ;
  void initState(){
    super.initState();
    getMeteoData(widget.keyword);
    getForecastData(widget.keyword);
    getMeteoTunData();

  }


  void getForecastData(String keyword) {

    print("Meteo Forecast Details de "+ keyword);
    String url=
        "https://api.openweathermap.org/data/2.5/forecast?q=${keyword}&lang=en&appid=82afcbf2dcbb11581bede04043abfd42";
    http.get(Uri.parse(url)).then((resp){
      setState(() {

        this.ForecastMeteoData= json.decode (resp.body);

        fat.addAll(ForecastMeteoData['list']) ;
        for (var c=0 ; c<fat.length;c++) {
          fa.add(fat[c]['dt_txt']);
          la.add((fat[c]['main']['temp'] -273.15 ).round());
        }
        print("aaaaaaaaaaaaaaaaaaaaaa");

        print(this.fa);
        print("bbbbbbbbbbbb");

        print(this.la);
        load();

      });
    }).catchError((err){
      print(err);
    });
  }

  void getMeteoData( String keyword) {
    print("Meteo Details de "+ keyword);
    String url=
        "https://api.openweathermap.org/data/2.5/weather?q=${keyword}&lang=en&appid=82afcbf2dcbb11581bede04043abfd42";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.MeteoData= json.decode (resp.body);

      });
    }).catchError((err){
      print(err);
    });
  }
  void getMeteoTunData( ) {

    for (var i = 0; i < cities.length; i++) {
      String url=
          "https://api.openweathermap.org/data/2.5/weather?q=${cities[i]}&lang=en&appid=82afcbf2dcbb11581bede04043abfd42";
      http.get(Uri.parse(url)).then((resp){
        setState(() {
          this.MeteoDataTun= jsonDecode (resp.body);
          Five.add(MeteoDataTun);


        });
      }).catchError((err){
        print(err);
      });

    }

  }





        @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(MeteoData == null
          ? Center(child: CircularProgressIndicator())
          :Container(
        child: Column(
          children: <Widget> [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                      image: AssetImage(
                        'assets/images/cloud-in-blue-sky.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                      //TODO
                      Align(
                        alignment: Alignment(0.0, 0.6),
                        child: SizedBox(
                          height: 10,
                          width: 10,
                          child: OverflowBox(
                            minWidth: 0.0,
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 0.0,
                            maxHeight: (MediaQuery.of(context).size.height / 3.2),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        //TODO
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 0, left: 20, right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  '${MeteoData['name']}'
                                                      .toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 24,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontFamily:
                                                    'flutterfonts',
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  DateFormat()
                                                      .add_MMMMEEEEd()
                                                      .format(DateTime.now()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                    fontFamily:
                                                    'flutterfonts',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        //TODO
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 50),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    '${MeteoData['weather'][0]['description']}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 22,
                                                      fontFamily:
                                                      'flutterfonts',
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "${(MeteoData['main']['temp'] -273.15 ).round()} C°",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                        color: Colors.black45,
                                                        fontFamily:
                                                        'flutterfonts'),
                                                  ),
                                                  Text(
                                                    "min: ${(MeteoData['main']['temp_min'] -273.15 ).round()} C° / max: ${(MeteoData['main']['temp_min'] -273.15 ).round()} C°",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontFamily:
                                                      'flutterfonts',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 110,
                                                    height: 110,
                                                    child: Image.asset('assets/images/${MeteoData['weather'][0]['main'].toString().toLowerCase()}.png'),



                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'wind ${MeteoData['wind']['speed']} m/s',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                        color: Colors.black45,
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontFamily:
                                                        'flutterfonts',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ),
            Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 80),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'other city'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                  fontSize: 16,
                                  fontFamily: 'flutterfonts',
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(

                              height: 150,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    VerticalDivider(
                                      color: Colors.transparent,
                                      width: 5,
                                    ),
                                itemCount: cities.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 140,
                                    height: 140,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(

                                                   '${Five[index]['name']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                              ),
                                            ),
                                            Text(

                                                  '${(Five[index]['main']['temp'] !- 273.15).round().toString()}C°',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset('assets/images/${Five[index]['weather'][0]['main'].toString().toLowerCase()}.png'),


                                            ),
                                            Text(

                                                  '${Five[index]['weather'][0]['description']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'forcast next 5 days'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Icon(
                                    Icons.next_plan_outlined,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            Container(

                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    SplineSeries<FiveDayData, String>(
                                      dataSource: Liste,
                                      xValueMapper: (FiveDayData details, _) =>
                                      details.fa,
                                      yValueMapper: (FiveDayData details, _) =>
                                      details.la,
                                    ),
                                  ],
                                ),
                              ),


                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),

      )
      )
        );
  }


}
class FiveDayData {
  final String fa;
  final int? la;

  FiveDayData(this.fa, this.la);



}



