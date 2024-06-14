import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/style/theme.dart' as Style;
import 'package:flutter_application_4/widgets/genres.dart';
import 'package:flutter_application_4/widgets/now_playing.dart';
import 'package:flutter_application_4/widgets/persons.dart';
import 'package:flutter_application_4/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Movie App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(EvaIcons.searchOutline),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          TopMovies()
        ],
      ),
    );
  }
}
