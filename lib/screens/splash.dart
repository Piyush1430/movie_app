import "dart:convert";
//Package
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get_it/get_it.dart";
//Screen
import 'package:movie_app/models/app_config.dart';
import "package:movie_app/services/http_service.dart";
import "package:movie_app/services/movie_service.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitizational});
  final VoidCallback onInitizational;
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitizational(),
      ),
    );
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = jsonDecode(configFile);
    getIt.registerSingleton<AppConfig>(
      AppConfig(
        API_KEY: configData["API_KEY"],
        BASE_API_URL: configData["BASE_API_URL"],
        BASE_IMAGE_API_URL: configData["BASE_IMAGE_API_URL"],
      ),
    );

    getIt.registerSingleton<HTTPService>(
      HTTPService(),
    );
    getIt.registerSingleton<Movieservice>(
      Movieservice(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flicked",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain)),
        ),
      ),
    );
  }
}
