import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_recognition/screens_new/home_screen.dart';
import 'package:text_recognition/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseService databaseService = DatabaseServiceImpl();
  await databaseService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
