import 'dart:io';
import 'package:MovieProject/model/movietitle.dart';
import 'package:MovieProject/model/movietitle_response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:MovieProject/model/movie_response.dart';

class MovieTitleRepository {
  final String url = "https://truyenapi.herokuapp.com/";
  Future<dynamic> getMovieTitles() async {
    try {
      dynamic movie;
      http.Response response = await http.get(Uri.parse(url + "movietitle/"));
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
