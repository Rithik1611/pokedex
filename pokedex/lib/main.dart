import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/services/https_service.dart';
import 'package:pokedex/widget/database_service.dart';

void main() async {
  await _setupService();
  runApp(const MyApp());
}

Future<void> _setupService() async {
  GetIt.instance.registerSingleton<HttpsService>(HttpsService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POKEDEX',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
            useMaterial3: true,
            textTheme: GoogleFonts.quattrocentoSansTextTheme()),
        home: const HomePage(),
      ),
    );
  }
}
