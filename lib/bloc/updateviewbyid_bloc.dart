import 'package:MovieProject/repository/updateviewbyidrepository.dart';

class UpdateViewByIDBloc {
  UpdateViewByIDRepository _updateViewByIDRepository =
      UpdateViewByIDRepository();
  // StreamController _moviesByIDController = StreamController.broadcast();
  // Stream getMoviesStream(){
  //   return _moviesByIDController.stream;
  // }
 getMovies(String id) async {
   //print(id);
    await _updateViewByIDRepository.getMovies(id);
    //print(response);
    //_moviesByIDController.sink.add(response);
  }
  // dispose(){
  //   _moviesByIDController.close();
  // }
  //final movieBloc = MovieBloc();
}
