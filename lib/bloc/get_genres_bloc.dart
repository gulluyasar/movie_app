import 'package:flutter_application_4/model/genre_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresListBloc {
  //BehaviorSubject RxDart kütüphanesinin bir parçası.Sürekli olarak güncellenen verileri izlemek ve paylaşmak amacıyla kullanılır.
  final MovieRepository _repository = MovieRepository(); //Repository= Depo
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response); //sink= çukur?
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenresListBloc();
