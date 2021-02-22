import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/model/movietitle_response.dart';
import 'package:MovieProject/repository/movierepository.dart';
import 'package:MovieProject/repository/movietitlerepository.dart';
import 'package:flutter/cupertino.dart';

class MovieTitleBloc {
  MovieTitleRepository _movietitleRepository = MovieTitleRepository();
  StreamController _movietitlesController = StreamController();
  Stream getMovieTitlesStream() {
    return _movietitlesController.stream;
  }

  getMovies() async {
    
    dynamic response = await _movietitleRepository.getMovieTitles();
    //print(response);
    _movietitlesController.sink.add(response);
  }

  dispose() {
    _movietitlesController.close();
  }

  //final movietitleBloc = MovieTitleBloc();
}
