import 'package:flutter/material.dart';
//import 'package:flutter_application_4/model/cast_response.dart';
import 'package:flutter_application_4/model/movie_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getSimilarMovies(int id) async {
    MovieResponse response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  } //burdaki null kullanımını kabul etmiyor muhtemelen hata aırsan kontrol et.

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final similarMoviesBloc = SimilarMoviesBloc();
