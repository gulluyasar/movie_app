import 'package:flutter_application_4/model/person.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse(this.persons, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons = (json["results"] as List)
            .map((i) => new Person.fromJson(i))
            .toList(),
        error = "";

  PersonResponse.withError(String errorValue)
      : persons =
            [], //MovieResponse.withError yönteminde movies özelliğine boş bir liste atadık.Hata olduğunda liste boş olur bu şekilde.
        error = errorValue;
}
