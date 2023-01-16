import 'package:flutter/material.dart';

class DetailsImageCard extends StatelessWidget {
  final String image;
  const DetailsImageCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/$image',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
