import 'dart:developer';
import 'package:bluetooth_flutter_app/services/api_services.dart' as Tv;
import 'package:flutter/material.dart';

class TvDescriptionScreen extends StatelessWidget {
  const TvDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvId = ModalRoute.of(context)!.settings.arguments as int;
    log(tvId.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      // appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          future: Tv.ApiServices().getTvById(tvId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${snapshot.data.backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.name,
                            // textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                    snapshot.data.voteAverage.toInt(), (index) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  );
                                }),
                              ),
                              Text(
                                '  ${snapshot.data.voteAverage.toStringAsFixed(1)}/10',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.genres.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[900],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Center(
                                            child: Text(
                                              snapshot.data.genres[index].name,
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data.overview,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Produced By',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.productionCompanies.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500' +
                                          snapshot
                                              .data
                                              .productionCompanies[index]
                                              .logoPath,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
