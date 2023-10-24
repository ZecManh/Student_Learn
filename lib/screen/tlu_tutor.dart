import 'package:flutter/material.dart';

class TluTutor extends StatelessWidget {
  const TluTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness:Brightness.light ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      title: 'Tlu Tutor',
      home: Scaffold(
        appBar: AppBar(title: Text('Tlu Tutor'),),
        body: Text('Hello'),
      ),
    );
  }
}
