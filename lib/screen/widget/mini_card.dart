import 'package:flutter/material.dart';

class MiniCard extends StatelessWidget {
  MiniCard({required this.cardName, super.key});

  String cardName;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              cardName,
              style: TextStyle(fontSize: 14),
            )));
  }
}
