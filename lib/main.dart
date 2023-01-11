import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/providers/database_provider.dart';
import 'package:text_recognition/screen/home_screen.dart';
import 'package:text_recognition/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseService db = DatabaseServiceImpl();
  await db.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DatabaseProvider(db: db),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
