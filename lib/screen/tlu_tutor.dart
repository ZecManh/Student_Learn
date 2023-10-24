import 'package:flutter/material.dart';

// final kColorScheme=ColorScheme.fromSeed(seedColor:Color.fromARGB(255, 255, 223, 223));
final kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 205, 92, 8));

final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 205, 92, 8), brightness: Brightness.dark);

class TluTutor extends StatelessWidget {
  const TluTutor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(),
              textStyle: TextStyle(fontSize: 20)),
        ),
      ),
      theme: ThemeData().copyWith(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(),
              textStyle: TextStyle(fontSize: 20)),
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Tlu Tutor',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tlu Tutor'),
        ),
        body: Column(
          children: [
            Text(
              'Hello',
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              icon: Icon(Icons.alarm),
              label: Text('Alarm'),
            )
          ],
        ),
      ),
    );
  }
}
