import 'package:flutter/material.dart';
import 'package:flutter_application_4/bloc/get_genres_bloc.dart';
import 'package:flutter_application_4/model/genre.dart';
import 'package:flutter_application_4/model/genre_response.dart';
import 'package:flutter_application_4/widgets/genres_list.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genresBloc
            .subject.stream, //dinlemek istediğim akışı belirttiğim yer.
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null &&
                snapshot.data!.error.length > 0) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildGenreWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error!);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Error oluştu: ${error.toString()}")],
      ),
    );
  }

  Widget _buildGenreWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text("Tür yok :("),
      );
    } else
      return GenresList(genres: genres);
  }
}
