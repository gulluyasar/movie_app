import 'package:flutter/material.dart';
import 'package:flutter_application_4/bloc/get_casts_bloc.dart';
import 'package:flutter_application_4/model/cast.dart';
import 'package:flutter_application_4/model/cast_response.dart';
import 'package:flutter_application_4/style/theme.dart' as Style;

class Casts extends StatefulWidget {
  //const Casts({super.key});

  final int id;
  Casts({Key? key, required this.id}) : super(key: key);

  @override
  State<Casts> createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;
  _CastsState(this.id);

  @override
  void initState() {
    super.initState();
    castsBloc..getCasts(id);
  }

  @override
  void dispose() {
    super.dispose();
    castsBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "OYUNCULAR",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse>(
            stream: castsBloc
                .subject.stream, //dinlemek istediğim akışı belirttiğim yer.
            builder: (context, AsyncSnapshot<CastResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error.length > 0) {
                  return _buildErrorWidget(snapshot.data!.error);
                }
                return _buildCastsWidget(snapshot.data!);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error!);
              } else {
                return _buildLoadingWidget();
              }
            }),
      ],
    );
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

  Widget _buildCastsWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    if (casts.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Kişi bulunmamaktadır",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 140.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                  top: 10.0,
                  right: 8.0,
                ),
                width: 100.0,
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w300/" +
                                        casts[index].img))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        casts[index].name,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 9.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        casts[index].character,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.0),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
  }
}
