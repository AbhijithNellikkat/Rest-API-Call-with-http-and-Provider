  import 'package:flutter/material.dart';
  import 'package:http_app/app/controllers/pets_controller.dart';
  import 'package:http_app/app/views/home_view.dart';
  import 'package:provider/provider.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return ChangeNotifierProvider(
        create: (_) => PetsController() ,
        child: MaterialApp(
          title: 'Rest API App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
            useMaterial3: true,
          ),
          home: HomeView(),
        ),
      );
    }
  }
