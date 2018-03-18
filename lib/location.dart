import 'dart:async';
import 'package:latlong/latlong.dart';

import 'package:flutter/services.dart';

const MethodChannel _channel = const MethodChannel('lyokone/location');
const EventChannel _stream = const EventChannel('lyokone/locationstream');

Stream<Position> _onPositionChanged;

Future<Position> get getPosition => _channel.invokeMethod('getLocation');

Stream<Position> get onPositionChanged {
  if (_onPositionChanged == null) {
    _onPositionChanged = _stream.receiveBroadcastStream().map(toPosition);
  }
  return _onPositionChanged;
}

class Position {
  final LatLng latLng;
  final double accuracy;
  final double altitude;

  Position(this.latLng, this.accuracy, this.altitude);
}

Position toPosition(dynamic event) {
  var map = event as Map;
  return new Position(new LatLng(map['latitude'] as double, map['latitude'] as double),
      map['accuracy'] as double, map['altitude'] as double);
}
