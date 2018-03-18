import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position _currentPosition;
  StreamSubscription<Position> _positionSubscription;

  bool currentWidget = true;

  Image image1;
  Image image2;


  @override
  initState() {
    super.initState();
    initPlatformState();
    _positionSubscription =
        onPositionChanged.listen((Position result) {
          setState(() {
            _currentPosition = result;
          });
        });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Position location;
    // Platform messages may fail, so we use a try/catch PlatformException.


    try {
      location = await getPosition;
    } on PlatformException {
      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted)
      return;

    setState(() {
      _currentPosition = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(currentWidget){
      image1 = new Image.network("https://maps.googleapis.com/maps/api/staticmap?center=${_currentPosition.latLng.latitude},${_currentPosition.latLng.longitude}&zoom=18&size=640x400&key=YOUR_API_KEY");
      currentWidget = !currentWidget;
    }else{
      image2 = new Image.network("https://maps.googleapis.com/maps/api/staticmap?center=${_currentPosition.latLng.latitude},${_currentPosition.latLng.longitude}&zoom=18&size=640x400&key=YOUR_API_KEY");
      currentWidget = !currentWidget;
    }

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body:
           new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Stack(
                children: <Widget>[image1, image2]),
              new Center(child:new Text('$_currentPosition\n')),
            ],
          )
        )
    );
  }
}
