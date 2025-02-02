import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/db/database_service.dart';
import 'package:if_noticies/screens/notices_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService().initDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IF Noticies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: GoogleFonts.openSansCondensed(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          color: const Color(0xFF2F9E41),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      home: const NoticesListScreen(),
    );
  }
}
