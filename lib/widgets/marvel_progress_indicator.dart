import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MarvelProgressIndicator extends StatelessWidget {
  const MarvelProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SpinKitWave(
        color: Colors.red,
        size: 48.0,
      ),
    );
  }
}
