import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String content;
  final void Function() callback;
  const MyOutlinedButton({required this.callback,required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return  OutlinedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.primary),
          foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.background)),
      onPressed: callback,
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          content,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );

  }
}
