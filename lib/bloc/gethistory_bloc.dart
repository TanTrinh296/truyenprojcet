import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/preference_share/preference_share.dart';
import 'package:MovieProject/repository/movierepository.dart';

class HistoryBloc {
  PreferenceShare _preferenceShare = PreferenceShare();
  StreamController _historyController = StreamController.broadcast();
  //StreamController _historyReadingController = StreamController.broadcast();
  Stream getMoviesStream() {
    return _historyController.stream;
  }

  // Stream getHistoryReadingStream() {
  //   return _historyReadingController.stream;
  // }

  setHistory(String s, data) async {
    await _preferenceShare.setPreference(s, data);
  }

  setHistoryReading(String s, data) async {
    await _preferenceShare.setPreferenceReading(s, data);
  }

  getKey() async {
    List keys = await _preferenceShare.getKey();
    return keys;
  }

  getAllHistory() async {
    List keys = await getKey();
    List data = [];
    keys.forEach((element) async {
      // print(element);
      if (!element.toString().contains("_")&&element.toString()!="checkcolor") {
        //print(element);
        var item = await _preferenceShare.getPreference(element);
        //print(item);
        data.add(item);
      }
    });
    //print(data);
    _historyController.sink.add(data);
  }

  getHistoryReading(String key) async {
    String item = "";
    item = await _preferenceShare.getPreferenceReading(key);
    var convert = {"title": item};
    return convert;
    // _historyReadingController.sink.add(convert);
  }

  deleteHistory(String key) async {
    await _preferenceShare.deletePreference(key);
  }

  existHistory(String key) async {
    bool result = await _preferenceShare.existKey(key);
    var convert  = {
      "result":result.toString()
    };
    return convert;
  }

  dispose() {
    _historyController.close();
    //_historyReadingController.close();
  }
  //final movieBloc = MovieBloc();
}
