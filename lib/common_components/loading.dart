import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final String loaderType;
  Loader(this.loaderType);
  @override
  Widget build(BuildContext context) {
    switch (loaderType) {
      case 'splash':
        {
          return SpinKitRotatingCircle(
            color: Colors.blue[900],
            size: 20.0,
          );
        }

      case 'image_load':
        {
          return SpinKitRing(
            color: Colors.blue[900],
            size: 20.0,
          );
        }
    }
  }
}
