import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future setBool(String key, bool value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setBool(key, value);
}

Future<void> setMap(String key, Map<String, dynamic>? value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (value != null) {
    String jsonString = jsonEncode(value);
    _prefs.setString(key, jsonString);
  } else {
    _prefs.remove(key);
  }

}

Future setInt(String key, int value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setInt(key, value);
}

Future setString(String key, String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(key, value);
}

Future setStringList(String key, List<String> value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setStringList(key, value);
}

Future setDouble(String key, double value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setDouble(key, value);
}

///////////////////////////////////////////////

Future getBool(String key) async {
  bool? _value;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _value = _prefs.getBool(key);
  return _value;
}

Future<Map<String, dynamic>?> getMap(String key) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? jsonString = _prefs.getString(key);
  if (jsonString == null) {
    return {};
  }
  Map<String, dynamic>? _decodedMap = jsonDecode(jsonString);
  if (_decodedMap != null) {
    _decodedMap = _decodedMap.map((key, value) => MapEntry(key.toString(), value));
  }
  return _decodedMap;
}

Future getInt(String key) async {
  int? _value;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _value = _prefs.getInt(key);
  return _value;
}

Future getString(String key) async {
  String? _value;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _value = _prefs.getString(key);
  return _value;
}

Future getStringList(String key) async {
  List<String>? _value;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _value = _prefs.getStringList(key);
  return _value;
}

Future getDouble(String key) async {
  double? _value;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _value = _prefs.getDouble(key);
  return _value;
}

////////////////////////////////////////////////////////////////

Future removeValue(String key) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.remove(key);
}