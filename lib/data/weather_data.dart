import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson40/models/model_weather.dart';

Future<Weather> weatherApi(String country) async {
  Uri url = Uri.parse("https://goweather.herokuapp.com/weather/$country");

  var _keladiganMalumot = await http.get(url);
  debugPrint("Weather " + _keladiganMalumot.body);
  return Weather.fromJson(jsonDecode(_keladiganMalumot.body));
}
