import 'package:flutter_application_4/model/genre.dart';

class MovieDetail {
  //soru işaretlerini hata aldığım için ekledim hata alırsan burayı kontrol et sebebi bu olabilir.
  final int? id;
  final bool? adult;
  final int? budget;
  final List<Genre>? genres;
  final String? releaseDate;
  final int? runtime;

  MovieDetail(this.id, this.adult, this.budget, this.genres, this.releaseDate,
      this.runtime);

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        adult = json["adult"],
        budget = json["budget"],
        genres =
            (json["genres"] as List).map((i) => new Genre.fromJson(i)).toList(),
        releaseDate = json["release_date"],
        runtime = json["runtime"];
}
