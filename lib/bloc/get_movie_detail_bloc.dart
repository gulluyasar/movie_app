import 'package:flutter/material.dart';
//import 'package:flutter_application_4/model/cast_response.dart';
import 'package:flutter_application_4/model/movie_detail_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieDetailResponse> _subject =
      BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    MovieDetailResponse response = await _repository.getMovieDetail(id);
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

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();
