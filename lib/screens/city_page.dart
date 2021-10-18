import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson40/data/weather_data.dart';
import 'package:lesson40/models/model_countries.dart';
import 'package:lesson40/models/model_weather.dart';
import 'package:lesson40/screens/preview_page.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:lesson40/screens/lists_page.dart';

class CityPage extends StatefulWidget {
  Countries country;

  CityPage(this.country, {Key? key}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  Countries? _countries;
  Color _white = Colors.white;
  Color _grey = Colors.grey;
  Color _black = Colors.black;
  Color _transparent = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _countries = widget.country;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  _getBody() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, top: 70.0),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage("https://source.unsplash.com/random/2"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: _grey,
            child: IconButton(
              onPressed: () {
                Navigator.pop((context));
              },
              icon: Icon(
                Icons.arrow_back,
                color: _white,
              ),
            ),
          ),
          Spacer(),
          // _showWeather(),r
          Row(
            children: [
              // Icon(Icons.),  // WEATHER ICON KELISHI KERAK
              Column(
                children: [

                ],
              )
            ],
          ),
          Text(
            _countries!.name!.common.toString(),
            style: TextStyle(
              color: _white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              height: 2,
            ),
          ),
          Text(
           _countries!.capital![0].toString(),
            style: TextStyle(
              color: _grey,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          ),
          Row(
            children: [
              _buttons("PREVIEW", _white),
              SizedBox(
                width: 12.0,
              ),
              _buttons("START ROUND", Colors.green),
            ],
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Expanded _buttons(String _text, Color _backColor) {
    return Expanded(
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PreviewPage()));
          },
          child: Text(_text)),
    );
  }

  _showWeather() => FutureBuilder(
      future: weatherApi("Tashkent"),
      builder: (context, AsyncSnapshot<Weather> snap) {
        return (snap.hasData)
            ? Row(
                children: [
                  Icon(Icons.cloud),
                  Column(
                    children: [
                      Text(
                        "${snap.data!.description.toString()}",
                        style: TextStyle(
                          color: _white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          height: 2,
                        ),
                      ),
                      Text(
                        "Api'dan keladi",
                        style: TextStyle(
                          color: _white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : CupertinoActivityIndicator(
                radius: 10,
              );
      });
}
