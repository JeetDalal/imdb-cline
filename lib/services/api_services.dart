import 'dart:convert';
import 'dart:developer';
import 'package:bluetooth_flutter_app/screens/home.dart';
import 'package:bluetooth_flutter_app/services/movie_datail_api.dart';
import 'package:bluetooth_flutter_app/services/popular_movies_api.dart';
import 'package:bluetooth_flutter_app/services/tv_by_id.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb_api/tmdb_api.dart';
import './tv_data.dart' as Tv;

class ApiServices {
  //Get movie by id
  Future getMovieById(int movieId) async {
    try {
      TMDB tmdb = TMDB(
        ApiKeys(
          'c138c289b0b0fbdbb7affd8acc411091',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTM4YzI4OWIwYjBmYmRiYjdhZmZkOGFjYzQxMTA5MSIsInN1YiI6IjYzYmYyOWNhMjNiZTQ2MDBiMmYwNTg1OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tjunxf5vMfM_pwtumWTpUaP1xwrGIvB5se4B1URsYC0',
        ),
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ),
      );
      Map<String, dynamic> movie =
          await tmdb.v3.movies.getDetails(movieId) as Map<String, dynamic>;
      final movieDetails = MovieDetailsApi.fromJson(movie);
      return movieDetails;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  Future getMovieData() async {
    try {
      TMDB tmdb = TMDB(
        ApiKeys(
          'c138c289b0b0fbdbb7affd8acc411091',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTM4YzI4OWIwYjBmYmRiYjdhZmZkOGFjYzQxMTA5MSIsInN1YiI6IjYzYmYyOWNhMjNiZTQ2MDBiMmYwNTg1OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tjunxf5vMfM_pwtumWTpUaP1xwrGIvB5se4B1URsYC0',
        ),
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ),
      );
      var movieList = [];
      Map<String, dynamic> popularMovies =
          await tmdb.v3.movies.getPopular() as Map<String, dynamic>;
      // var data = Result.fromJson(popularMovies);
      // log(popularMovies.toString());
      for (var i in popularMovies['results']) {
        movieList.add(Result.fromJson(i));
      }
      return movieList;
    } catch (e) {
      log(e.toString());
    }
  }

  Future tvData() async {
    try {
      TMDB tmdb = TMDB(
        ApiKeys(
          'c138c289b0b0fbdbb7affd8acc411091',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTM4YzI4OWIwYjBmYmRiYjdhZmZkOGFjYzQxMTA5MSIsInN1YiI6IjYzYmYyOWNhMjNiZTQ2MDBiMmYwNTg1OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tjunxf5vMfM_pwtumWTpUaP1xwrGIvB5se4B1URsYC0',
        ),
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ),
      );
      var tvList = [];
      Map<String, dynamic> popularTvShows =
          await tmdb.v3.tv.getPopular() as Map<String, dynamic>;
      // var data = Result.fromJson(popularMovies);
      // log(popularMovies.toString());
      for (var i in popularTvShows['results']) {
        tvList.add(Tv.Result.fromJson(i));
      }
      return tvList;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getTvById(tvId) async {
    try {
      TMDB tmdb = TMDB(
        ApiKeys(
          'c138c289b0b0fbdbb7affd8acc411091',
          'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTM4YzI4OWIwYjBmYmRiYjdhZmZkOGFjYzQxMTA5MSIsInN1YiI6IjYzYmYyOWNhMjNiZTQ2MDBiMmYwNTg1OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tjunxf5vMfM_pwtumWTpUaP1xwrGIvB5se4B1URsYC0',
        ),
        logConfig: const ConfigLogger(
          showErrorLogs: true,
          showLogs: true,
        ),
      );
      Map<String, dynamic> movie =
          await tmdb.v3.tv.getDetails(tvId) as Map<String, dynamic>;
      final tvDetails = TvByIdApi.fromJson(movie);
      return tvDetails;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  itemAnimateList() {
    var actualList = getMovieData();
    var dataList = [];
    actualList.then(
      (value) => value.forEach(
        (e) {
          dataList.add(e);
          animatedList.currentState!.insertItem(dataList.length - 1);
        },
      ),
    );
  }
}
