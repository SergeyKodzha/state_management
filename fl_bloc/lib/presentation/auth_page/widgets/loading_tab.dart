import 'package:flutter/material.dart';

class LoadingTab extends StatelessWidget {
  const LoadingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
