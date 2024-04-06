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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> d7da0de55a68cd20f11e32dd51d1560dce867246
>>>>>>> 66f7fa4e7b87e6b6434900a37f91e6ce00051b83
    return GetMaterialApp(
        locale: const Locale('vi', 'VN'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('vi', 'VN'), // Tiếng Việt
          // Các ngôn ngữ khác nếu cần
        ],
<<<<<<< HEAD
    home: LoginPage(),debugShowCheckedModeBanner: false,);
=======
    home: HomeScreen(),debugShowCheckedModeBanner: false,);
<<<<<<< HEAD
=======
=======
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LoginPage()),
    );
>>>>>>> d5a2edf93dfee3fe952d550430fe77e8974b21fb
>>>>>>> d7da0de55a68cd20f11e32dd51d1560dce867246
>>>>>>> 66f7fa4e7b87e6b6434900a37f91e6ce00051b83
  }
}
