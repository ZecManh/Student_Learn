import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:datn/screen/wrapper.dart';
import 'package:datn/viewmodel/user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/auth/firebase_auth_service.dart';
import '../database/firestore/firestore_service.dart';

// final kColorScheme=ColorScheme.fromSeed(seedColor:Color.fromARGB(255, 255, 223, 223));
final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 205, 92, 8));

final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 205, 92, 8),
    brightness: Brightness.dark);

enum Screen { chooseType, learnerLogin, tutorLogin }

class TluTutor extends StatefulWidget {
  const TluTutor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TluTutorState();
  }
}

class _TluTutorState extends State<TluTutor> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthService>(
            create: (context) => FirebaseAuthService()),
        ChangeNotifierProvider<FirestoreService>(
            create: (_) => FirestoreService()),
        ChangeNotifierProvider<UserTypeModel>(
          create: (_) => UserTypeModel(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kDarkColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.primary),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: const RoundedRectangleBorder(),
                  textStyle: const TextStyle(fontSize: 20)),
            ),
          ),
          theme: ThemeData(fontFamily: 'Linotte').copyWith(
            brightness: Brightness.light,
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColorScheme.primaryContainer,
                foregroundColor: kColorScheme.primary),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: const RoundedRectangleBorder(),
                  textStyle: const TextStyle(fontSize: 20)),
            ),
            cardTheme: const CardTheme().copyWith(
                color: kColorScheme.primaryContainer,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          ),
          themeMode: ThemeMode.light,
          title: 'Tlu Tutor',
          // home: const ChooseTypeScreen()
          home: const Wrapper()),
    );
  }
}
