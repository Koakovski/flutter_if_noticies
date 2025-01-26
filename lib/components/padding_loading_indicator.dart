import 'package:flutter/material.dart';

class PaddingLoadingIndicator extends StatelessWidget {
  const PaddingLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CircularProgressIndicator(),
    );
  }
}
