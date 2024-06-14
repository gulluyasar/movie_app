import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/cast_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CastsBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getCasts(int id) async {
    CastResponse response = await _repository.getCasts(id);
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

  BehaviorSubject<CastResponse> get subject => _subject;
}

final castsBloc = CastsBloc();
