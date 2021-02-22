import 'package:MovieProject/model/movie.dart';

class MovieResponse{
  List<Movie> movies;
  String error;

  MovieResponse(this.movies,this.error);
  MovieResponse.fromJson(Map<String,dynamic>json){
    this.movies=(json["result"] as List).map((e) => new Movie.fromJson(e)).toList();
    this.error="";
  }
  MovieResponse.withError(String errorValue){
    this.movies=List();
    this.error=errorValue;
  }
}