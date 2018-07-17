import 'package:flutter/material.dart';
import 'dart:async';
import "package:intl/intl.dart";
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ticker',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ticker'),
        ),

        body: new TimeLabel(),
      ),
    );
  }
}

class TimeLabel extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new TimeState();
    }
}

class TimeState extends State {

  DateTime _time = new DateTime.now();
  DateFormat _f = new DateFormat('yyyy-MM-dd H:m:ss');

  @override
  initState() {
    super.initState();
    
     Timer.periodic(new Duration(microseconds: 20), (Timer t) {
      setState(() {
        _time = new DateTime.now();
      });
    }); 
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      var time = _f.format(_time) + ' ' + _time.millisecond.toString();
      return new Center(
        child: new Text(time)
      );
    }
}