import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:MovieProject/model/movie_response.dart';

class UpdateViewByIDRepository {
  final String url = "https://truyenapi.herokuapp.com/";
   getMovies(String id) async {
    // try {
    //dynamic movie;
    http.Response response = await http.patch(url + "movie/updateviewbyid/$id");
    //movie = json.decode(response.body);
   // print(movie);
    //return movie;
    // }
    //  catch (error, stackTrace) {
    //   print("Exception:$error stackTrace: $stackTrace ");
    //   return MovieTitleResponse.withError("$error");
    // }
  }
}
