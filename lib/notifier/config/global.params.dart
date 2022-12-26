import 'package:flutter/material.dart';
import 'package:voyage/notifier/theme.dart';
class GlobalParams{
 static List<Map<String,dynamic>>menus=[
  {"title":"Home","icon":Icon(Icons.home,color: Colors.blue,), "route" : "/home"},
  {"title":"Meteo","icon":Icon(Icons.sunny_snowing,color: Colors.blue,), "route" : "/meteo"},
  {"title":"Gallerie","icon":Icon(Icons.photo,color: Colors.blue,), "route" : "/gallerie"},
  {"title":"Pays","icon":Icon(Icons.location_city,color: Colors.blue,), "route" : "/pays"},
  {"title":"Contact","icon":Icon(Icons.contact_page,color: Colors.blue,), "route" : "/contact"},
  {"title":"Parametre","icon":Icon(Icons.settings,color: Colors.blue,), "route" : "/parametre"},
  {"title":"Déconnexion","icon":Icon(Icons.logout,color: Colors.blue,), "route" : "/authentification"},

 ];
 static Montheme themeActuel=Montheme();
}