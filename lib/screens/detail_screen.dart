import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/bloc/get_movie_videos_bloc.dart';
import 'package:flutter_application_4/model/movie.dart';
import 'package:flutter_application_4/model/video.dart';
import 'package:flutter_application_4/model/video_response.dart';
import 'package:flutter_application_4/screens/video_player.dart';
import 'package:flutter_application_4/style/theme.dart' as Style;
import 'package:flutter_application_4/widgets/casts.dart';
import 'package:flutter_application_4/widgets/movie_info.dart';
import 'package:flutter_application_4/widgets/similar_movies.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  //const MovieDetailScreen({super.key});
  final Movie movie;
  MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Movie movie;
  _MovieDetailScreenState(this.movie);

  @override
  void initState() {
    super.initState();
    MovieVideosBloc()..getMovieVideos(movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    MovieVideosBloc()..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Style.Colors.mainColor,
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  movie.title.length > 40
                      ? movie.title.substring(0, 37) + "..."
                      : movie.title,
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                background: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movie.backPoster))),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0)
                          ])),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<VideoResponse>(
                  stream: movieVideosBloc.subject.stream,
                  builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.error != null &&
                          snapshot.data!.error.length > 0) {
                        return _buildErrorWidget(snapshot.data!.error);
                      }
                      return _buildVideoWidget(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(snapshot.error!);
                    } else {
                      return _buildLoadingWidget();
                    }
                  }),
            ),
            SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          movie.rating.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar.builder(
                          itemSize: 10.0,
                          initialRating: movie.rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.secondColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text(
                      "Genel Bakış",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      movie.overview,
                      style: TextStyle(
                          color: Colors.white, fontSize: 12.0, height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  MovieInfo(
                    id: movie.id,
                  ),
                  Casts(id: movie.id),
                  SimilarMovies(id: movie.id)
                ])))
          ],
        ));
  }

  Widget _buildLoadingWidget() {
    return Container();
  }

  Widget _buildErrorWidget(Object error) {
    return Center(
      child: Column(
        children: <Widget>[Text("Error oluştu: ${error.toString()}")],
      ),
    );
  }

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
      backgroundColor: Style.Colors.secondColor,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                    controller: YoutubePlayerController(
                        initialVideoId: videos[0].key,
                        //flag= etiket
                        flags: YoutubePlayerFlags(
                            forceHD: true, autoPlay: true)))));
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
