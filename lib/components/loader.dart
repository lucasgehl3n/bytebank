import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String message;
  const Loader({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text(this.message),
        ],
      ),
    );
  }
}
