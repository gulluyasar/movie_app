import 'package:flutter_application_4/model/person_response.dart';
import 'package:flutter_application_4/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonsListBloc {
  //BehaviorSubject RxDart kütüphanesinin bir parçası.Sürekli olarak güncellenen verileri izlemek ve paylaşmak amacıyla kullanılır.
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response); //sink= çukur?
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonsListBloc();
