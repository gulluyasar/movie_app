import 'package:flutter_application_4/model/video.dart';

class VideoResponse {
  final List<Video> videos;
  final String error;

  VideoResponse(this.videos, this.error);

  VideoResponse.fromJson(Map<String, dynamic> json)
      : videos =
            (json["results"] as List).map((i) => Video.fromJson(i)).toList(),
        error = "";

  VideoResponse.withError(String errorValue)
      : videos =
            [], //Boş bir liste oluşturduk. izledğiğm videoda List() şeklinde tanımlıydı ben bu [] şekilde düzelttim.
        error = errorValue;
}
