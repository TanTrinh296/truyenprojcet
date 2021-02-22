import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:MovieProject/model/movie_response.dart';

class MovieGetEpisodeByIDRepository {
  final String url = "https://truyenapi.herokuapp.com/";
  Future<dynamic> getEpisode(String id, String title) async {
    try {
      dynamic body = {"title": title};
      dynamic movie;
      http.Response response =
          await http.post(url + "movie/getepisodebyid/$id", body: body);
      movie = json.decode(response.body);
      // print(movie);
      return movie;
    } on SocketException {
      return "Error";
    } on HttpException {
      return "Error";
    } on FormatException {
      return "Error";
    }
  }
}
