import 'dart:developer';
import 'package:bluetooth_flutter_app/services/api_services.dart';
import 'package:bluetooth_flutter_app/services/covid_api.dart';
import 'package:bluetooth_flutter_app/utils/categories.dart';
import 'package:flutter/material.dart';
import '../widgets/imdb_logo.dart';
import '../widgets/movie_card.dart';
import '../widgets/popular_movies.dart';
import '../widgets/search_box.dart';
import 'description_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

GlobalKey<AnimatedListState> animatedList = GlobalKey<AnimatedListState>();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ApiServices().itemAnimateList();
    });
  }

  // Tween<Offset> _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  var currentIndex = 0;
  Future<dynamic> function = ApiServices().getMovieData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ImdbLogo(),
                  SearchBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = index;
                          switch (currentIndex) {
                            case 0:
                              setState(() {
                                function = ApiServices().getMovieData();
                              });
                              break;
                            case 1:
                              setState(() {
                                function = ApiServices().getMovieData();
                              });
                              break;
                            case 2:
                              setState(() {
                                function = ApiServices().getMovieData();
                              });
                              break;
                            case 3:
                              setState(() {
                                function = ApiServices().getMovieData();
                              });
                              break;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: currentIndex == index ? 30 : 18,
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                            fontWeight:
                                currentIndex == index ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            DataList(context, currentIndex),
          ],
        ),
      ),
    );
  }
}

Widget DataList(BuildContext context, int currentIndex) {
  switch (currentIndex) {
    case 0:
      return FutureBuilder(
        future: ApiServices().getMovieData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: AnimatedList(
                key: animatedList,
                initialItemCount: snapshot.data.length,
                itemBuilder: (context, index, animation) {
                  Tween<Offset> offset =
                      Tween(begin: Offset(1, 0), end: Offset(0, 0));
                  return SlideTransition(
                    position: animation.drive(offset),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/des-route',
                            arguments: snapshot.data[index].id);
                      },
                      child: MovieCard(
                        status:
                            'Relase Date : ${snapshot.data[index].releaseDate.toString().substring(0, 10)}',
                        rating: snapshot.data[index].voteAverage,
                        date:
                            ' (${snapshot.data[index].releaseDate.toString().substring(0, 4)})',
                        imageUrl: 'https://image.tmdb.org/t/p/w500' +
                            snapshot.data[index].posterPath,
                        movieName: snapshot.data[index].title,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    case 2:
      return FutureBuilder(
        future: ApiServices().tvData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/des-route',
                          arguments: snapshot.data[index].id);
                    },
                    child: MovieCard(
                      date: '',
                      rating: snapshot.data[index].voteAverage,
                      imageUrl: 'https://image.tmdb.org/t/p/w500' +
                          snapshot.data[index].posterPath,
                      movieName: snapshot.data[index].name,
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    default:
      return Container();
  }
}
