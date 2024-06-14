import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/movie_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenreBloc {
  //BehaviorSubject RxDart kütüphanesinin bir parçası.Sürekli olarak güncellenen verileri izlemek ve paylaşmak amacıyla kullanılır.
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    MovieResponse response = await _repository.getMovieByGenre(id);

    _subject.sink.add(response); //sink= çukur?
  }

  //veri akış kontrolü?
  void drainStream() async {
    await _subject.drain(); //!!!!!burayı kontrol et hata sebebi olabilir!!!!!!!
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesByGenreBloc = MoviesListByGenreBloc();
