import 'package:ct240_doan/screens/duan_screen.dart';
import 'package:ct240_doan/screens/flash_screen.dart';
import 'package:ct240_doan/screens/home_screen.dart';
import 'package:ct240_doan/screens/login_page.dart';
import 'package:ct240_doan/screens/sample_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      locale: Locale('vi', 'VN'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('vi', 'VN'), // Tiếng Việt
        // Các ngôn ngữ khác nếu cần
      ],
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
