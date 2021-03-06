import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:MovieProject/model/movie_response.dart';

class MovieRepository {
  final String url = "https://truyenapi.herokuapp.com/";
  Future<dynamic> getMovies() async {
    try {
      dynamic movie;
      http.Response response = await http.get(url + "movie/");
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
