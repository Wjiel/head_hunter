import 'dart:async';

class BoolStream {
  StreamController _controller;
  BoolStream () : _controller = StreamController<bool>();
  BoolStream.broadcast () :_controller = StreamController<bool>.broadcast();
  bool _value = false;



  Stream boolStream() {
    return _controller.stream;
  }

  bool get value => _value;
  set value(bool newValue) {
    _value = newValue;
   _controller.add(newValue);
  }

  void dispose() {
    _value = false;
    _controller = StreamController<bool>();
  }
}

class ListStream {
  StreamController _controller;
  ListStream () : _controller = StreamController<List>();
  ListStream.broadcast () :_controller = StreamController<List>.broadcast();
  List _value = [];



  Stream listStream<List>() {
    return _controller.stream;
  }

  List get value => _value;
  set value(List newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  void dispose() {
    _value = [];
    _controller = StreamController<List>();
  }
}

class MapStream {
  StreamController _controller;
  MapStream () : _controller = StreamController<Map<String, dynamic>>();
  MapStream.broadcast () :_controller = StreamController<Map<String, dynamic>>.broadcast();
  Map<String, dynamic> _value = {};



  Stream mapStream() {
    return _controller.stream;
  }

  Map<String, dynamic> get value => _value;
  set value(Map<String, dynamic> newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  void dispose() {
    _value = {};
    _controller = StreamController<Map<String, dynamic>>();
  }
}

class DoubleStream {
  StreamController _controller;
  DoubleStream () : _controller = StreamController<double>();
  DoubleStream.broadcast () :_controller = StreamController<double>.broadcast();
  double _value = 1;


  Stream doubleStream() {
    return _controller.stream;
  }

  double get value => _value;
  set value(double newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  void dispose() {
    _value = 1;
    _controller = StreamController<double>();
  }
}

class IntStream {
  StreamController _controller;
  IntStream () : _controller = StreamController<int>();
  IntStream.broadcast () :_controller = StreamController<int>.broadcast();
  int _value = 1;


  Stream intStream() {
    return _controller.stream;
  }

  int get value => _value;
  set value(int newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  void dispose() {
    _value = 1;
    _controller = StreamController<int>();
  }
}

class StringStream {
  StreamController _controller;
  StringStream () : _controller = StreamController<String>();
  StringStream.broadcast () :_controller = StreamController<String>.broadcast();
  String _value = '';


  Stream stringStream() {
    return _controller.stream;
  }

  String get value => _value;
  set value(String newValue) {
    _value = newValue;
    _controller.add(newValue);
  }

  void dispose() {
    _value = '';
    _controller = StreamController<String>();
  }
}