import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson40/data/countries_data.dart';
import 'package:lesson40/models/model_countries.dart';
import 'package:lesson40/screens/city_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Size? _size;
  Color _white = Colors.white;
  Color _grey = Colors.grey;
  Color _black = Colors.black;
  Color _transparent = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: _botNavBar(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: _transparent,
        elevation: 0,
        title: Text(
          "Countries",
          style: TextStyle(
              color: _black, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12.0),
            child: Text(
              'Find a place to play golf',
              style: TextStyle(
                color: _grey,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          _formField(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12.0, top: 12.0),
            child: Text(
              "Cities",
              style: TextStyle(
                color: _black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          _listOfCities(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12.0, top: 12.0),
            child: Text(
              "Top Rated",
              style: TextStyle(
                color: _black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 6.0,
            ),
            child: FutureBuilder(
              future: countriesApi,
              builder: (context, AsyncSnapshot snap) {
                return _listContainer(snap.data![0]);
              }
            ),
          ),
        ],
      );

  TextFormField _formField() => TextFormField(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          focusColor: _transparent,
          fillColor: _transparent,
          filled: true,
          hintText: "Type to search...",
          prefixIcon: Icon(CupertinoIcons.search, color: _black),
        ),
      );

  _listOfCities() => FutureBuilder(
        future: countriesApi,
        builder: (context, AsyncSnapshot snap) {
          return (snap.hasData)
              ? Container(
                  width: 400.0,
                  height: 200.0,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 6.0, bottom: 12.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) => _listContainer(snap.data![index]),
                  ),
                )
              : CupertinoActivityIndicator(
                  radius: 10,
                );
        },
      );

  InkWell _listContainer(Countries _c) {
    debugPrint(_c.region);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CityPage(_c)));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          margin: EdgeInsets.all(10.0),
          height: 200.0,
          width: 170.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: _grey,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://source.unsplash.com/random/2",
              ),
            ),
          ),
          child: _texRate(_c.name!.common!)),
    );
  }

  Widget _texRate(String countries) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            countries,
            style: TextStyle(
              color: _white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              height: 2,
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 12.0),
              SizedBox(width: 5),
              Text(
                "Api'dan keladi",
                style: TextStyle(
                  color: _grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _botNavBar() => BottomNavigationBar(
          currentIndex: 3,
          selectedItemColor: Colors.green,
          unselectedItemColor: _grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.flag,
              ),
              label: "",
            ),
          ]);
}
