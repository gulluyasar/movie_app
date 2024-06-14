import 'package:flutter_application_4/model/movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        error = "";

  MovieResponse.withError(String errorValue)
      : movies =
            [], //MovieResponse.withError yönteminde movies özelliğine boş bir liste atadık.Hata olduğunda liste boş olur bu şekilde.
        error = errorValue;
}
