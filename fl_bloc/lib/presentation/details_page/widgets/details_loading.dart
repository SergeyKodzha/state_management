import 'package:flutter/material.dart';

class DetailsLoading extends StatelessWidget {
  const DetailsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(),);
  }
}
