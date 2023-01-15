import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieCard extends StatelessWidget {
  final String movieName;
  final double rating;
  final String date;
  final String imageUrl;
  String? status;
  MovieCard({
    this.status,
    required this.rating,
    required this.date,
    required this.imageUrl,
    required this.movieName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Container(
        // color: Colors.blueGrey[900],
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          movieName.length >= 16
                              ? "${movieName.substring(0, 14)}..."
                              : movieName,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          date,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  status ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    // fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: RatingBar(
                    itemCount: 10,
                    itemSize: 20,
                    initialRating: rating,
                    allowHalfRating: true,
                    maxRating: 10,
                    minRating: 1,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      empty: const Icon(
                        Icons.star_border_outlined,
                        color: Colors.yellow,
                        size: 18,
                      ),
                    ),
                    onRatingUpdate: (data) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
