import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:MovieProject/model/movie_response.dart';

class MovieByIDRepository {
  final String url = "https://truyenapi.herokuapp.com/";
  Future<dynamic> getMovies(String id) async {
    try {
      dynamic movie;
      http.Response response =
          await http.get(Uri.parse(url + "movie/getmoviebyid/$id"));
      movie = json.decode(response.body);
      print(response.statusCode);
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
