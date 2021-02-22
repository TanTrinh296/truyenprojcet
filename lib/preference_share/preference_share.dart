import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceShare {
  setPreference(String key, data) async {
    // print(data);
    //print(json.encode(data));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, json.encode(data));
    // print(json.decode(preferences.getString(key)));
    // print(preferences.getKeys());
  }
  setPreferenceReading(String key, String data) async {
    // print(data);
    //print(json.encode(data));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
    // print(json.decode(preferences.getString(key)));
    // print(preferences.getKeys());
  }
   setPreferenceBackGroundColors(String key, String data) async {
    // print(data);
    //print(json.encode(data));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
    // print(preferences.getKeys());
    // print(json.decode(preferences.getString(key)));
    // print(preferences.getKeys());
  }
  getKey() async {
    List keys = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys().forEach((element) {
      if (element != "null") {
        keys.add(element);
      }
    });
    return keys;
  }

  getPreference(key) async {
    //print(key);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //print(json.decode(preferences.getString(key)));
    var result = json.decode(preferences.getString(key));
    return result;
  }

  getPreferenceReading(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //print(preferences.getString(key));
    var result = preferences.getString(key);
    return result;
  }

  deletePreference(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  cleanPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  existKey(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result =false;
    preferences.getKeys().forEach((element) {
      // print(element);
      if (element == key) {
        //print(key);
        result= true;
      }
    });
    return result;
  }
}
