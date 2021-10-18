import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson40/models/model_countries.dart';

Future<List<Countries>> _countriesApi() async {
  Uri url = Uri.parse("https://restcountries.com/v3.1/all");

  var _keladiganMalumot = await http.get(url);
  List<Countries> _countries = (jsonDecode(_keladiganMalumot.body) as List)
      .map((e) => Countries.fromJson(e))
      .toList();
  return _countries;
}

Future get countriesApi => _countriesApi();
