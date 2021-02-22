import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/preference_share/preference_share.dart';
import 'package:MovieProject/repository/movierepository.dart';

class BackGroundColorsBloc {
  PreferenceShare _preferenceShare = PreferenceShare();

  setBackGroundColors(String s, String data) async {
    // print(s);
    // print(data);
    await _preferenceShare.setPreferenceBackGroundColors(s, data);
  }

  deleteBackGroundColors(String key) async {
    await _preferenceShare.deletePreference(key);
  }

  existBackGroundColors(String key) async {
    bool result = await _preferenceShare.existKey(key);
    // print(result);
    return result;
  }
  //final movieBloc = MovieBloc();
}
