//Packages
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
//screens
import "package:movie_app/screens/home.dart";
import "package:movie_app/screens/splash.dart";

void main() {
  runApp(
    SplashScreen(
        key: UniqueKey(),
        onInitizational: () {
          return runApp(const ProviderScope(
            child: MyApp(),
          ));
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flicked",
      initialRoute: "home",
      routes: {
        "home": (context) =>  HomeScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
