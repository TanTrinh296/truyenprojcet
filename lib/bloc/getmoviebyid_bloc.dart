import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/repository/moviebyidrepository.dart';
import 'package:MovieProject/repository/movierepository.dart';

class MovieByIDBloc {
  MovieByIDRepository _movieByIDRepository = MovieByIDRepository();
  StreamController _moviesByIDController = StreamController.broadcast();
  Stream getMoviesStream() {
    return _moviesByIDController.stream;
  }

  getMovies(String id) async {
    dynamic response = await _movieByIDRepository.getMovies(id);
    //print(response);
    _moviesByIDController.sink.add(response);
  }

  getNull() {
    _moviesByIDController.sink.add(null);
  }

  dispose() {
    _moviesByIDController.close();
  }
  //final movieBloc = MovieBloc();
}
