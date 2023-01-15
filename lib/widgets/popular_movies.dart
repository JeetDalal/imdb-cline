import 'package:flutter/material.dart';

import '../services/api_services.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices().getMovieData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Text(snapshot.data[index].title);
            },
          );
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
}
