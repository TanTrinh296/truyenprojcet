import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/repository/moviebyviewrepository.dart';
import 'package:MovieProject/repository/movierandomrepository.dart';
import 'package:MovieProject/repository/movierepository.dart';

class MovieBloc {
  MovieRepository _movieRepository = MovieRepository();
  MovieRanDomRepository _movieRanDomRepository = MovieRanDomRepository();
  MovieByViewRepository _movieByViewRepository = MovieByViewRepository();
  StreamController _moviesController = StreamController.broadcast();
  StreamController _moviesRandomController = StreamController.broadcast();
  StreamController _moviesByViewController = StreamController.broadcast();
  Stream getMoviesStream() {
    return _moviesController.stream;
  }

  Stream getMoviesRandomStream() {
    return _moviesRandomController.stream;
  }

  Stream getMoviesByViewStream() {
    return _moviesByViewController.stream;
  }

  getMovies() async {
    dynamic response = await _movieRepository.getMovies();
    //print(response);
    _moviesController.sink.add(response);
    return response;
  }

  getMoviesByView() async {
    dynamic response = await _movieByViewRepository.getMovies();
    //print(response);
    _moviesByViewController.sink.add(response);
    return response;
  }

  getMoviesRandom() async {
    dynamic response = await _movieRanDomRepository.getMovies();
    //print(response);
    _moviesRandomController.sink.add(response);
    return response;
  }

  getNull() async {
    // dynamic response = await _movieRepository.getMovies();
    //print(response);
    _moviesController.sink.add(null);
    // return response;
  }

  getNullByView() async {
    // dynamic response = await _movieByViewRepository.getMovies();
    //print(response);
    _moviesByViewController.sink.add(null);
    // return response;
  }

  dispose() {
    _moviesController.close();
    _moviesByViewController.close();
    _moviesRandomController.close();
  }
  //final movieBloc = MovieBloc();
}
