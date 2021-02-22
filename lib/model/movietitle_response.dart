import 'package:MovieProject/model/movie.dart';
import 'package:MovieProject/model/movietitle.dart';

class MovieTitleResponse{
  List<MovieTitle> movietitles;
  String error;

  MovieTitleResponse(this.movietitles,this.error);
  MovieTitleResponse.fromJson(Map<String,dynamic>json){
    this.movietitles=(json["result"] as List).map((e) => new MovieTitle.fromJson(e)).toList();
    this.error="";
  }
  MovieTitleResponse.withError(String errorValue){
    this.movietitles=List();
    this.error=errorValue;
  }
}