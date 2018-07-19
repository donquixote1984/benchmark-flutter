import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ticker',
      home: new Scaffold(
        appBar: new AppBar(),
        body: new BookList(),
      )
    );
  }

}

class BookList extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new BookListState();
    }
}

class BookListState extends State {

  var _countries = new List<Country>();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      _fetchBooks();
    }

    _fetchBooks() async{
      final response = await http.get('https://jsonplaceholder.typicode.com/photos');
      List countries = JSON.decode(response.body);

      setState(() {
              this._countries = countries.map<Country>((c) {
                  return Country.fromJson(c);
              }).toList();
      });
    }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      var size = this._countries.length;
      return new Container(
        child: new GridView.count(
          crossAxisCount: 2,
          children: this._countries.map<Widget>((c) { return CountryCard.from(c);}).toList()
        )
      );
    }
}

class CountryCard extends StatelessWidget {
  final Country country;
  CountryCard({this.country});

  factory CountryCard.from(country) {
    return new CountryCard(country: country);
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Stack(
        children: [
          Image.network(this.country.image),
          Positioned(
            child: new Text(this.country.name),
            left:10.0,
            bottom: 10.0
          ),
          Positioned(
            child: new RaisedButton(
              onPressed: () {print(this.country.name);},
              child:new Icon(Icons.thumb_up) 
              ),
            right: 10.0,
            top: 10.0
          )
        ]
      );
    }
}
class Country {
  final String image;
  final String name;

  Country({this.name, this.image});

  factory Country.fromJson(Map json) {
    return new Country(
      image: json['url'],
      name: json['title']
    );
  }
}