import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitFadingGrid(
        color: Theme.of(context).primaryColor,
        size: 50,
      ),
    );
  }
}
