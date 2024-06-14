import 'package:flutter_application_4/model/movie_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBloc {
  //BehaviorSubject RxDart kütüphanesinin bir parçası.Sürekli olarak güncellenen verileri izlemek ve paylaşmak amacıyla kullanılır.
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getPlayingMovies();
    _subject.sink.add(response); //sink= çukur?
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingMoviesBloc = NowPlayingListBloc();
