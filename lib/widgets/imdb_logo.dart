import 'package:flutter/material.dart';

class ImdbLogo extends StatelessWidget {
  const ImdbLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Center(
        child: Text(
          'IMDB',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
