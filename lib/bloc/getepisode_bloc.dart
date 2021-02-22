import 'dart:async';

import 'package:MovieProject/model/movie_response.dart';
import 'package:MovieProject/repository/moviebyidrepository.dart';
import 'package:MovieProject/repository/moviegetepisodebyid.dart';
import 'package:MovieProject/repository/movierepository.dart';

class MovieEpisodeByIDBloc {
  MovieGetEpisodeByIDRepository _movieByIDRepository =
      MovieGetEpisodeByIDRepository();
  StreamController _moviesEpisodeByIDController = StreamController.broadcast();
  Stream getEpisodeStream() {
    return _moviesEpisodeByIDController.stream;
  }

  getEpisode(String id, String title) async {
    dynamic response = await _movieByIDRepository.getEpisode(id, title);
    _moviesEpisodeByIDController.sink.add(response);
    return response;
  }
  getNull(){
     _moviesEpisodeByIDController.sink.add(null);
  }
  dispose() {
    _moviesEpisodeByIDController.close();
  }
  //final movieBloc = MovieBloc();
}
