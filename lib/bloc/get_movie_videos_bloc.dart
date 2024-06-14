import 'package:flutter/material.dart';
//import 'package:flutter_application_4/model/cast_response.dart';
import 'package:flutter_application_4/model/video_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc {
  final MovieRepository _repository = MovieRepository();
  late final BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();

  getMovieVideos(int id) async {
    VideoResponse response = await _repository.getMovieVideos(id);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain(); //burda sürekli hata veriyor düzelt burayı.
  } //burdaki null kullanımını kabul etmiyor muhtemelen hata alırsın kontrol et.

//üst kısmı boş bir _subject.drain() i async await formatında kullanarakk düzelttik.Önceki hali _subject.drain = null; idi.
  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
