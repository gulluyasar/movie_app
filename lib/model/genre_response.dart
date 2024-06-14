import 'package:flutter_application_4/model/genre.dart';

class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse(this.genres, this.error);

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((i) => new Genre.fromJson(i)).toList(),
        error = "";

  GenreResponse.withError(String errorValue)
      : genres =
            [], //MovieResponse.withError yönteminde movies özelliğine boş bir liste atadık.Hata olduğunda liste boş olur bu şekilde.
        error = errorValue;
}
