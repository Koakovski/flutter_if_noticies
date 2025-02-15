import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/common/app_colors.dart';
import 'package:if_noticies/db/database_service.dart';
import 'package:if_noticies/screens/notices_list_screen.dart';
import 'package:if_noticies/services/notice_fetcher_service/notice_fetcher_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await DatabaseService().initDb();
  await NoticeFetcherService().replaceNoticesOnCache();

  FlutterNativeSplash.remove();

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
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: GoogleFonts.openSansCondensed(
            color: AppColors.textOnPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          color: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
      ),
      home: const NoticesListScreen(),
    );
  }
}
